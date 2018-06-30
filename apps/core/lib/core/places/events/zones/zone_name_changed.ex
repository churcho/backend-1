defmodule Core.Places.Events.ZoneNameChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :zone_uuid,
    :name
  ]
end
