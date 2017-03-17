defmodule Core.LocationView do
  use Core.Web, :view

  def render("index.json", %{locations: locations}) do
    %{
      links: %{ self: "/api/v1/locations"},
      data: render_many(locations, Core.LocationView, "show.json")
    }
  end

  def render("show.json", %{location: location}) do
    zones = location.zones

    %{
     type: "locations",
     id: location.id,
     included: %{
       zones: render_many(zones, Core.ZoneView, "show.json")
       },
     attributes: render_one(location, Core.LocationView, "location.json"),
     links: %{
       self: "/api/v1/locations/#{location.id}"
     },


   }
  end

  def render("created.json", %{location: location}) do
    zones = location.zones

    %{
     type: "locations",
     id: location.id,
     attributes: render_one(location, Core.LocationView, "location.json"),
     links: %{
       self: "/api/v1/locations/#{location.id}"
     },


   }
  end

  def render("location.json", %{location: location}) do
      %{
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


  end
end
