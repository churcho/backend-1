defmodule Core.LocationView do
  use Core.Web, :view

  def render("index.json", %{locations: locations}) do
    %{
      links: %{ self: "/api/v1/locations"},
      data: render_many(locations, Core.LocationView, "location.json")
    }
  end

  def render("show.json", %{location: location}) do
    zones = location.zones

    %{
     data: render_one(location, Core.LocationView, "location.json")
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
       zones: render_many(location.zones |> Core.Repo.preload([:location, :rooms]) , Core.ZoneView, "zone.json")
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
end
