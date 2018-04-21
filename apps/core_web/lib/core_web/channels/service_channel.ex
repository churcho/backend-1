defmodule CoreWeb.ServiceChannel do
  @moduledoc """
  Service Channel
  """
  use CoreWeb, :channel
  alias CoreWeb.Endpoint
  alias Core.ServiceManager

  alias Core.Repo

  def join("services:all", _payload, socket) do
    {:ok, socket}
  end

  def handle_in("services:start", %{"service" => service}, socket) do
    service
    |> ServiceManager.get_service!()

    broadcast!(socket, "new_msg", %{})
    {:noreply, socket}
  end

  def handle_in("services:stop", %{"service" => service}, socket) do
    service
    |> ServiceManager.get_service!()

    broadcast!(socket, "new_msg", %{})
    {:noreply, socket}
  end

  def handle_in("services:reload", %{"service" => service}, socket) do
    service
    |> ServiceManager.get_service!()

    broadcast!(socket, "new_msg", %{})
    {:noreply, socket}
  end

  def handle_in("services:server_update", %{"service" => service}, socket) do
    serv =
      service
      |> ServiceManager.get_service!()
      |> Repo.preload(:provider)

    backend = Module.concat(serv.provider.configuration["service_name"], Server)
    backend.build_state()
    {:noreply, socket}
  end

  def handle_in("services:server_init", %{"service" => service}, socket) do
    service
    |> ServiceManager.get_service!()
    |> Repo.preload(:provider)
    |> ServiceManager.init_service()

    {:noreply, socket}
  end

  def handle_in("services:server_remove", %{"service" => service}, socket) do
    service
    |> ServiceManager.get_service!()
    |> Repo.preload(:provider)
    |> ServiceManager.remove_service()

    {:noreply, socket}
  end

  def handle_in("services:authorize", %{"service" => service}, socket) do
    service
    |> ServiceManager.get_service!()
    |> Repo.preload(:provider)
    |> ServiceManager.authorize_service()

    {:noreply, socket}
  end

  def handle_in("services:import", %{"service_id" => service_id}, socket) do
    service_id
    |> ServiceManager.get_service!()
    |> ServiceManager.import_entities()

    broadcast!(socket, "import_started", %{msg: "import_started"})

    {:noreply, socket}
  end

  def broadcast_service_message(message) do
    Endpoint.broadcast("services:all", "message", message)
  end
end
