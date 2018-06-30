defmodule Core.Places.Commands.DeleteRoom do
  @moduledoc false
  defstruct [
    room_uuid: "",
  ]

  use ExConstructor
  use Vex.Struct

  alias Core.Places.Projections.Room
  alias Core.Places.Commands.DeleteRoom

  validates :room_uuid, uuid: true

  def assign_room(%DeleteRoom{} = delete, %Room{uuid: room_uuid}) do
    %DeleteRoom{delete |
      room_uuid: room_uuid,
    }
  end

end
