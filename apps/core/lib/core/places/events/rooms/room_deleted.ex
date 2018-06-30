defmodule Core.Places.Events.RoomDeleted do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :room_uuid
  ]
end
