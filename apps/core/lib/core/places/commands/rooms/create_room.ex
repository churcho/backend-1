defmodule Core.Places.Commands.CreateRoom do
  @moduledoc """
  Create a role
  """

    defstruct [
      room_uuid: "",
      name: "",
      description: "",
      zone_uuid: "",
    ]

    use ExConstructor
    use Vex.Struct

    alias Core.Places.Commands.CreateRoom

    validates :room_uuid, uuid: true

    @doc """
    Assign a unique identity for the role
    """
    def assign_uuid(%CreateRoom{} = create_room, uuid) do
      %CreateRoom{create_room | room_uuid: uuid}
    end
  end
