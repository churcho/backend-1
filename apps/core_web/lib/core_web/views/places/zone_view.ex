defmodule CoreWeb.ZoneView do
  use CoreWeb, :view

  def render("index.json", %{zones: zones}) do
    %{
      links: %{self: "/api/v1/places/zones"},
      data: render_many(zones, CoreWeb.ZoneView, "zone.json")
    }
  end

  def render("show.json", %{zone: zone}) do
    %{
      data: render_one(zone, CoreWeb.ZoneView, "zone.json")
    }
  end

  def render("zone.json", %{zone: zone}) do
    %{
      links: %{
        self: "/api/v1/places/zones/#{zone.uuid}"
      },
      uuid: zone.uuid,
      name: zone.name,
      description: zone.description,
      location_uuid: zone.location_uuid
    }
  end
end
