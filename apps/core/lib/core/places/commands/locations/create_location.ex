defmodule Core.Places.Commands.CreateLocation do
  @moduledoc """
  Create a role
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
      latitude: nil,
      longitude: nil,
      location_type: ""
    ]

    use ExConstructor
    use Vex.Struct

    alias Core.Places.Commands.CreateLocation
    alias Core.Places.Geocoder

    validates :location_uuid, uuid: true

    @doc """
    Assign a unique identity for the role
    """
    def assign_uuid(%CreateLocation{} = create_location, uuid) do
      %CreateLocation{create_location | location_uuid: uuid}
    end

    def assign_coords(%CreateLocation{} = create_location) do
      IO.puts "Geocoding"
      address = Geocoder.compose_address(create_location)
      coords = Geocoder.get_coords_from_address(address)

      if coords do
        %CreateLocation{create_location | latitude: coords.lat, longitude: coords.lng}
      end
    end
  end
