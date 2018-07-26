defmodule CoreWeb.LocationView do
  use CoreWeb, :view

  def render("index.json", %{locations: locations}) do
    %{
      links: %{self: "/api/v1/places/locations"},
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
        self: "/api/v1/places/locations/#{location.id}"
      },
      id: location.id,
      name: location.name,
      description: location.description,
      address_one: location.address_one,
      address_two: location.address_two,
      address_city: location.address_city,
      address_state: location.address_state,
      address_zip: location.address_zip,
      latitude: location.latitude,
      longitude: location.longitude,
      dst_offset: location.dst_offset,
      raw_time_offset: location.raw_time_offset,
      sunrise: location.sunrise,
      sunset: location.sunset
    }
end
end
