defmodule Core.Places.Events.RoomCreated do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :room_uuid,
    :name,
    :description,
    :zone_uuid
  ]
end
