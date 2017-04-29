defmodule Core.Web.ServiceChannel do
  @moduledoc """
  Service Channel
  """
  use Core.Web, :channel


  def join("services:" <> _service_id , _payload, socket) do
      {:ok, socket}
    end

  def handle_in("service:start", %{"service" => service}, socket) do
    service
    |> Core.ServiceManager.get_service!()
    broadcast! socket, "new_msg", %{}
    {:noreply, socket}
  end

  def handle_in("service:stop", %{"service" => service}, socket) do
    service
    |> Core.ServiceManager.get_service!()
    broadcast! socket, "new_msg", %{}
    {:noreply, socket}
  end

  def handle_in("service:reload", %{"service" => service}, socket) do
    serv = Core.ServiceManager.get_service!(service)
    IO.puts serv.id
    broadcast! socket, "new_msg", %{}
    {:noreply, socket}
  end

  def handle_in("service:server_update", %{"service" => service}, socket) do
    serv =
    service
    |> Core.ServiceManager.get_service!()
    |> Core.Repo.preload(:provider)

    backend = Module.concat(serv.provider.configuration["service_name"], Server)
    backend.build_state()
    {:noreply, socket}
  end

  def handle_in("service:server_init", %{"service" => service}, socket) do
    serv =
    service
    |> Core.ServiceManager.get_service!()
    |> Core.Repo.preload(:provider)

    backend = Module.concat(serv.provider.configuration["service_name"], Server)
    backend.build_state()
    {:noreply, socket}
  end

  def handle_in("service:server_remove", %{"service" => service}, socket) do
    serv =
    service
    |> Core.ServiceManager.get_service!()
    |> Core.Repo.preload(:provider)

    backend = Module.concat(serv.provider.configuration["service_name"], Server)
    backend.clear_state()
    {:noreply, socket}
  end

  def handle_in("service:authorize", %{"service" => service}, socket) do
    serv = Core.ServiceManager.get_service!(service)
    backend = Module.concat(serv.provider.configuration["service_name"], Auth)
    backend.start_link(serv)
    {:noreply, socket}
  end

  def handle_in("service:import", %{"service_id" => service_id}, socket) do
    serv = Core.ServiceManager.get_service!(service_id)
    backend = Module.concat(serv.provider.configuration["service_name"], Importer)
    backend.update(serv)
    {:noreply, socket}
  end

  def broadcast_service_message(message, service) do
    Core.Web.Endpoint.broadcast("services:" <> to_string(service), "message", message)
  end



end
