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

    alias Core.Places.Commands.CreateLocation

    validates :location_uuid, uuid: true

    @doc """
    Assign a unique identity for the role
    """
    def assign_uuid(%CreateLocation{} = create_location, uuid) do
      %CreateLocation{create_location | location_uuid: uuid}
    end
  end
