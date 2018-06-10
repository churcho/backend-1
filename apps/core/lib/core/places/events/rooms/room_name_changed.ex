defmodule Core.Places.Events.RoomNameChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :room_uuid,
    :name,
  ]
end
