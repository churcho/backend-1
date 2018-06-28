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

  validates :location_uuid, uuid: true

  @doc """
  Assign the Location identity
  """
  def assign_location(%UpdateLocation{} = update_location, %Location{uuid: location_uuid}) do
    %UpdateLocation{update_location | location_uuid: location_uuid}
  end
end
