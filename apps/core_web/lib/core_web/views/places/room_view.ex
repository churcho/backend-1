defmodule CoreWeb.RoomView do
  use CoreWeb, :view

  def render("index.json", %{rooms: rooms}) do
    %{
      links: %{self: "/api/v1/places/rooms"},
      data: render_many(rooms, CoreWeb.RoomView, "room.json")
    }
  end

  def render("show.json", %{room: room}) do
    %{
      data: render_one(room, CoreWeb.RoomView, "room.json")
    }
  end

  def render("room.json", %{room: room}) do
    %{
      links: %{
        self: "/api/v1/places/rooms/#{room.id}"
      },
      id: room.id,
      name: room.name,
      description: room.description,
      zone_id: room.zone_id
    }
  end
end
