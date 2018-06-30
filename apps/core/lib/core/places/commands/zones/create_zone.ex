defmodule Core.Places.Commands.CreateZone do
  @moduledoc """
  Create a role
  """

    defstruct [
      zone_uuid: "",
      name: "",
      description: "",
      location_uuid: "",
    ]

    use ExConstructor
    use Vex.Struct

    alias Core.Places.Commands.CreateZone

    validates :zone_uuid, uuid: true

    @doc """
    Assign a unique identity for the role
    """
    def assign_uuid(%CreateZone{} = create_zone, uuid) do
      %CreateZone{create_zone | zone_uuid: uuid}
    end
  end
