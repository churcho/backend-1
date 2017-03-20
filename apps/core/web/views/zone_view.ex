defmodule Core.ZoneView do
  use Core.Web, :view

  def render("index.json", %{zones: zones}) do
    %{
      links: %{
        self:  "/api/v1/zones"
      },
      data: render_many(zones, Core.ZoneView, "zone.json")
    }
  end

  def render("show.json", %{zone: zone}) do
    %{
      data: render_one(zone, Core.ZoneView, "zone.json")
    }
  end

  def render("zone.json", %{zone: zone}) do
    %{      
      id: zone.id,
      links: %{
        self: "/api/v1/zones/#{zone.id}"
      },
      attributes: %{
        name: zone.name,
        description: zone.description,
        location_id: zone.location_id,
        state: zone.state
      }
    }
  end
end
