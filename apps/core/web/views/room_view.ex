defmodule Core.RoomView do
  use Core.Web, :view

  def render("index.json", %{rooms: rooms}) do
    %{
      links: %{ self: "/api/v1/rooms"},
      data: render_many(rooms, Core.RoomView, "room.json")
    }
  end

  def render("show.json", %{room: room}) do
    %{data: render_one(room, Core.RoomView, "room.json")}
  end

  def render("room.json", %{room: room}) do
    %{
      links: %{ self: "/api/v1/rooms/#{room.id}"},
      id: room.id,
      attributes: %{
        name: room.name,
        description: room.description,
        zone_id: room.zone_id,
        zone_name: room.zone.name
      }
    }
  end
end
