defmodule Core.Places.Events.RoomDescriptionChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :room_uuid,
    :description
  ]
end
