defmodule Core.Web.ServiceChannel do
  use Core.Web, :channel

  
  def join("services:" <> service_id , payload, socket) do
    {:ok, socket}
  end

  def handle_in("service:start", %{ "service" => service}, socket) do
    IO.puts "Starting Service"
    IO.inspect service
    broadcast! socket, "new_msg", %{}
    {:noreply, socket}
  end

  def handle_in("service:stop", %{ "service" => service}, socket) do
    IO.puts "Stopping Service"
    IO.inspect service
    broadcast! socket, "new_msg", %{}
    {:noreply, socket}
  end

  def handle_in("service:reload", %{ "service" => service}, socket) do
    IO.puts "Reloading Service"
    IO.inspect service
    broadcast! socket, "new_msg", %{}
    {:noreply, socket}
  end

  def handle_in("service:authorize", %{ "service" => service}, socket) do
    IO.puts "Authorizing Service"
    IO.inspect service
    serv = Core.ServiceManager.get_service!(service)
    Huebris.Auth.start_link(serv)
    {:noreply, socket}
  end

  def handle_in("service:import", %{ "service_id" => service_id, "service_name" => service_name}, socket) do
    IO.puts "Authorizing Service"
    serv = Core.ServiceManager.get_service!(service_id)
    backend = Module.concat(service_name, Importer)
    backend.update(serv)
    {:noreply, socket}
  end

  def broadcast_service_message(message, service) do
    Core.Web.Endpoint.broadcast("services:"<>to_string(service), "message", message)
  end



end
