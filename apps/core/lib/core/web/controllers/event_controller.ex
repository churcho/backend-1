defmodule Core.Web.EventController do
  use Core.Web, :controller
  alias Core.EventManager
  alias Core.EventManager.Event
  alias Core.Web.EventChannel


  def index(conn, _params) do
    events = EventManager.list_events_desc()
    render(conn, "index.json", events: events)
  end

  def create(conn, event_params) do
    with {:ok, %Event{} = event} <- EventManager.create_event(event_params) do
      EventChannel.broadcast_change(event)
      conn
      |> put_status(:created)
      |> put_resp_header("location", event_path(conn, :show, event))
      |> render("show.json", event: event)
    end
  end

  def show(conn, %{"id" => id}) do
    event = EventManager.get_event!(id)
    render(conn, "show.json", event: event)
  end

  def update(conn, %{"id" => id, "event" => event_params}) do
    event = EventManager.get_event!(id)

    with {:ok, %Event{} = event} <- EventManager.update_event(event, event_params) do
      render(conn, "show.json", event: event)
    end
  end

  def delete(conn, %{"id" => id}) do
    event = EventManager.get_event!(id)
    with {:ok, %Event{}} <- EventManager.delete_event(event) do
      send_resp(conn, :no_content, "")
    end
  end
end
