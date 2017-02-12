defmodule Iotapi.ZoneView do
  use Iotapi.Web, :view

  def render("index.json", %{zones: zones}) do
    %{
      links: %{
        self:  "/api/v1/zones"
      },
      data: render_many(zones, Iotapi.ZoneView, "zone.json")
    }
  end

  def render("show.json", %{zone: zone}) do
    %{
      links: %{
        self: "/api/v1/zones/#{zone.id}"
      },
      type: "zones",
      id: zone.id,
      attributes: render_one(zone, Iotapi.ZoneView, "zone.json")
    }
  end

  def render("zone.json", %{zone: zone}) do
    %{
      name: zone.name,
      description: zone.description,
      location_id: zone.location_id,
      state: zone.state
    }
  end
end
