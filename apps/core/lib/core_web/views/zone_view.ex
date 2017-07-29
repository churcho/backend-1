defmodule CoreWeb.ZoneView do
  use CoreWeb, :view

  def render("index.json", %{zones: zones}) do
    %{
      links: %{
        self:  "/api/v1/zones"
      },
      data: render_many(zones, CoreWeb.ZoneView, "zone.json")
    }
  end

  def render("show.json", %{zone: zone}) do
    %{
      data: render_one(zone , CoreWeb.ZoneView, "zone.json")
     }
  end

  def render("zone.json", %{zone: zone}) do
    %{
      id: zone.id,
      links: %{
        self: "/api/v1/zones/#{zone.id}"
      },
      included: %{
       rooms: get_room_ids(zone.rooms)
      },
      attributes: %{
        name: zone.name,
        description: zone.description,
        location_id: zone.location_id,
        location_name: zone.location.name,
        state: zone.state
      }
    }
  end

  def get_room_ids(rooms) do
    for room <- rooms do
       room.id
    end
  end
end