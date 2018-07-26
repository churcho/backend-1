defmodule CoreWeb.RoomController do
  @moduledoc false
  use CoreWeb, :controller

  alias Core.Places
  alias Core.Places.Room

  def index(conn, _params) do
    rooms = Places.list_rooms()
    render(conn, "index.json", rooms: rooms)
  end

  def show(conn, %{"id" => id}) do
    room = Places.get_room!(id)
    render(conn, "show.json", room: room)
  end

  def delete(conn, %{"id" => id}) do
    room = Places.get_room!(id)

    with :ok <- Places.delete_room(room) do
      send_resp(conn, :no_content, "")
    end
  end

  def create(conn, %{"room" => room_params}) do
    with {:ok, %Room{} = room} <-
      Places.create_room(room_params)
    do
      conn
      |> put_status(:created)
      |> render("show.json", room: room)
    end
  end

  def update(conn, %{"id" => room_id, "room" => room_params}) do

    room = Places.get_room!(room_id)

    with {:ok, %Room{} = room} <-
      Places.update_room(room, room_params)
    do
      conn
      |> put_status(:ok)
      |> render("show.json", room: room)
    end
  end
end
