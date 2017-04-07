defmodule Core.Web.RoomController do
  use Core.Web, :controller

  alias Core.LocationManager
  alias Core.LocationManager.Room


  def index(conn, _params) do
    rooms = LocationManager.list_zones()
    render(conn, "index.json", rooms: rooms)
  end

  def create(conn, %{"room" => room_params}) do
    with {:ok, %Room{} = room} <- LocationManager.create_room(room_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("room", room_path(conn, :show, room))
      |> render("show.json", room: room)
    end
  end


  def show(conn, %{"id" => id}) do
    room = LocationManager.get_room!(id)
    render(conn, "show.json", room: room)
  end

  def update(conn, %{"id" => id, "room" => room_params}) do
    room = LocationManager.get_room!(id)

    with {:ok, %Room{} = room} <- LocationManager.update_room(room, room_params) do
      render(conn, "show.json", room: room)
    end
  end

  def delete(conn, %{"id" => id}) do
    room = LocationManager.get_room!(id)
    with {:ok, %Room{}} <- LocationManager.delete_room(room) do
      send_resp(conn, :no_content, "")
    end
  end
end
