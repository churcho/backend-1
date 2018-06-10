defmodule Core.Places.Commands.UpdateRoom do
  @moduledoc """
  Command to update room
  """

  defstruct [
    room_uuid: "",
    name: "",
    description: "",
    zone_uuid: "",
  ]

  use ExConstructor
  use Vex.Struct

  alias Core.Places.Commands.UpdateRoom
  alias Core.Places.Projections.Room

  validates :room_uuid, uuid: true

  @doc """
  Assign the Room identity
  """
  def assign_room(%UpdateRoom{} = update_room, %Room{uuid: room_uuid}) do
    %UpdateRoom{update_room | room_uuid: room_uuid}
  end
end
