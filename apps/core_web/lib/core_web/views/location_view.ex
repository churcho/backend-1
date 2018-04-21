defmodule CoreWeb.LocationView do
  use CoreWeb, :view

  def render("index.json", %{locations: locations}) do
    %{
      links: %{self: "/api/v1/locations"},
      data: render_many(locations, CoreWeb.LocationView, "location.json")
    }
  end

  def render("show.json", %{location: location}) do
    %{
      data: render_one(location, CoreWeb.LocationView, "location.json")
    }
  end

  def render("location.json", %{location: location}) do
    %{
      links: %{
        self: "/api/v1/locations/#{location.id}"
      },
      id: location.id,
      type: "locations",
      included: %{
        zones: get_zone_ids(location.zones)
      },
      attributes: %{
        name: location.name,
        state: location.state,
        address_one: location.address_one,
        address_two: location.address_two,
        address_city: location.address_city,
        address_state: location.address_state,
        address_zip: location.address_zip,
        latitude: location.latitude,
        longitude: location.longitude
      }
    }
  end

  def get_zone_ids(zones) do
    for zone <- zones do
      zone.id
    end
  end
end
