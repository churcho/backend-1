defmodule CoreWeb.RoomView do
  use CoreWeb, :view

  def render("index.json", %{rooms: rooms}) do
    %{links: %{self: "/api/v1/rooms"},
      data: render_many(rooms, CoreWeb.RoomView, "room.json")
    }
  end

  def render("show.json", %{room: room}) do
    %{data: render_one(room, CoreWeb.RoomView, "room.json")}
  end

  def render("room.json", %{room: room}) do
    %{
      links: %{
        self: "/api/v1/rooms/#{room.id}"
        },
      id: room.id,
      attributes: %{
        name: room.name,
        description: room.description,
        zone_id: room.zone_id,
        zone_name: room.zone.name,
        location_id: room.zone_location.id,
        location_name: room.zone_location.name,
        lights: get_light_ids(room.light_entities)
      }
    }
  end

  def get_light_ids(lights) do
    for light <- lights do
       light.id
    end
  end
end
