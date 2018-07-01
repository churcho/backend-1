defmodule Core.Places.Commands.UpdateLocation do
  @moduledoc """
  Command to update location
  """

  defstruct [
    location_uuid: "",
    name: "",
    address_one: "",
    address_two: "",
    address_city: "",
    address_country: "",
    address_state: "",
    address_zip: "",
    slug: "",
    description: "",
    latitude: "",
    longitude: "",
    location_type: ""
  ]

  use ExConstructor
  use Vex.Struct

  alias Core.Places.Commands.UpdateLocation
  alias Core.Places.Projections.Location
  alias Core.Places.Geocoder

  validates :location_uuid, uuid: true

  @doc """
  Assign the Location identity
  """
  def assign_location(%UpdateLocation{} = update_location, %Location{uuid: location_uuid}) do
    %UpdateLocation{update_location | location_uuid: location_uuid}
  end

  def assign_coords(%UpdateLocation{} = update_location) do
    IO.puts "Geocoding"
    address = Geocoder.compose_address(update_location)
    coords = Geocoder.get_coords_from_address(address)

    if coords do
      %UpdateLocation{update_location | latitude: coords.lat, longitude: coords.lng}
    end
  end

end
