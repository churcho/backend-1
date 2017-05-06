defmodule Core.Web.ServiceChannel do
  @moduledoc """
  Service Channel
  """
  use Core.Web, :channel
  alias Core.ServiceManager
  alias Core.Repo

  def join("services:" <> _service_id , _payload, socket) do
      {:ok, socket}
  end

  def handle_in("service:start", %{"service" => service}, socket) do
    service
    |> ServiceManager.get_service!()
    broadcast! socket, "new_msg", %{}
    {:noreply, socket}
  end

  def handle_in("service:stop", %{"service" => service}, socket) do
    service
    |> ServiceManager.get_service!()
    broadcast! socket, "new_msg", %{}
    {:noreply, socket}
  end

  def handle_in("service:reload", %{"service" => service}, socket) do
    service
    |> ServiceManager.get_service!()
    broadcast! socket, "new_msg", %{}
    {:noreply, socket}
  end

  def handle_in("service:server_update", %{"service" => service}, socket) do
    serv =
    service
    |> ServiceManager.get_service!()
    |> Repo.preload(:provider)

    backend = Module.concat(serv.provider.configuration["service_name"], Server)
    backend.build_state()
    {:noreply, socket}
  end

  def handle_in("service:server_init", %{"service" => service}, socket) do
    service
    |> ServiceManager.get_service!()
    |> Repo.preload(:provider)
    |> ServiceManager.init_service()

    {:noreply, socket}
  end

  def handle_in("service:server_remove", %{"service" => service}, socket) do
    service
    |> ServiceManager.get_service!()
    |> Repo.preload(:provider)
    |> ServiceManager.remove_service()

    {:noreply, socket}
  end

  def handle_in("service:authorize", %{"service" => service}, socket) do
    service
    |> ServiceManager.get_service!()
    |> Repo.preload(:provider)
    |> SeriiceManager.authorize_service()

    {:noreply, socket}
  end

  def handle_in("service:import", %{"service_id" => service_id}, socket) do
    service_id
    |> ServiceManager.get_service!()
    |> Repo.preload(:provider)
    |> ServiceManager.import_entities()

    {:noreply, socket}
  end

  def broadcast_service_message(message, service) do
    Core.Web.Endpoint.broadcast("services:" <> to_string(service), "message", message)
  end



end
