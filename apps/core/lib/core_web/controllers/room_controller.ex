defmodule CoreWeb.RoomController do
  use CoreWeb, :controller

  alias Core.LocationManager
  alias Core.LocationManager.Room

  action_fallback CoreWeb.FallbackController

  def index(conn, _params) do
    rooms = LocationManager.list_rooms()
    render(conn, "index.json", rooms: rooms)
  end

  def create(conn, %{"room" => room_params}) do
    with {:ok, %Room{} = room} <- LocationManager.create_room(room_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("room", room_path(conn, :show, room))
      |> render("show.json", room: room |> Core.Repo.preload([:zone, :zone_location]))
    end
  end


  def show(conn, %{"id" => id}) do
    room = LocationManager.get_room!(id)
    render(conn, "show.json", room: room)
  end

  def update(conn, %{"id" => id, "room" => room_params}) do
    room = LocationManager.get_room!(id)

    with {:ok, %Room{} = room} <- LocationManager.update_room(room, room_params) do
      render(conn, "show.json", room: room |> Core.Repo.preload([:zone, :zone_location]))
    end
  end

  def delete(conn, %{"id" => id}) do
    room = LocationManager.get_room!(id)
    with {:ok, %Room{}} <- LocationManager.delete_room(room) do
      send_resp(conn, :no_content, "")
    end
  end
end
