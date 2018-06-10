defmodule Core.Places.Events.RoomZoneChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :room_uuid,
    :zone_uuid
  ]
end
