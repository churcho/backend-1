defmodule CoreWeb.EntityEventTypeController do
  use CoreWeb, :controller

  alias Core.EntityManager
  alias Core.EntityManager.EventType

  action_fallback CoreWeb.FallbackController

  def index(conn, _params) do
    event_types = EntityManager.list_event_types()
    render(conn, "index.json", event_types: event_types)
  end

  def create(conn, %{"event_type" => event_type_params}) do
    with {:ok, %EventType{} = event_type} <- EntityManager.create_event_type(event_type_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", entity_event_type_path(conn, :show, event_type))
      |> render("show.json", event_type: event_type)
    end
  end

  def show(conn, %{"id" => id}) do
    event_type = EntityManager.get_event_type!(id)
    render(conn, "show.json", event_type: event_type)
  end

  def update(conn, %{"id" => id, "event_type" => event_type_params}) do
    event_type = EntityManager.get_event_type!(id)

    with {:ok, %EventType{} = event_type} <- EntityManager.update_event_type(event_type, event_type_params) do
      render(conn, "show.json", event_type: event_type)
    end
  end

  def delete(conn, %{"id" => id}) do
    event_type = EntityManager.get_event_type!(id)
    with {:ok, %EventType{}} <- EntityManager.delete_event_type(event_type) do
      send_resp(conn, :no_content, "")
    end
  end
end
