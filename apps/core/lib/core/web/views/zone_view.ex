defmodule Core.Web.ZoneView do
  use Core.Web, :view

  def render("index.json", %{zones: zones}) do
    %{
      links: %{
        self:  "/api/v1/zones"
      },
      data: render_many(zones, Core.Web.ZoneView, "zone.json")
    }
  end

  def render("show.json", %{zone: zone}) do
    %{
      data: render_one(zone , Core.Web.ZoneView, "zone.json")
     }
  end

  def render("zone.json", %{zone: zone}) do
    %{      
      id: zone.id,
      links: %{
        self: "/api/v1/zones/#{zone.id}"
      },
      included: %{
       rooms: render_many(zone.rooms  |> Core.Repo.preload([:zone, :zone_location]), Core.Web.RoomView, "room.json")
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
end
