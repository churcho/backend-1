defmodule Iotapi.LocationView do
  use Iotapi.Web, :view

  def render("index.json", %{locations: locations}) do
    %{
      links: %{ self: "/api/v1/locations"},
      data: render_many(locations, Iotapi.LocationView, "location.json")
    }
  end

   def render("show.json", %{location: location}) do
     %{
       links: %{
         self: "/api/v1/locations/#{location.id}"
       },
       data: render_one(location, Iotapi.LocationView, "location.json")
     }
   end

  def render("location.json", %{location: location}) do
    %{id: location.id,
      name: location.name,
      location_state: location.state,
      address_one: location.address_one,
      address_two: location.address_two,
      city: location.city,
      state: location.state,
      zip: location.zip,
      latitude: location.latitude,
      longitude: location.longitude
    }
  end
end
