defmodule Core.RoomView do
  use Core.Web, :view

  def render("index.json", %{rooms: rooms}) do
    %{data: render_many(rooms, Core.RoomView, "room.json")}
  end

  def render("show.json", %{room: room}) do
    %{data: render_one(room, Core.RoomView, "room.json")}
  end

  def render("room.json", %{room: room}) do
    %{id: room.id,
      name: room.name,
      description: room.description,
      location_id: room.location_id}
  end
end
