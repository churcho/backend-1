defmodule Core.Places.Events.ZoneLocationChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :zone_uuid,
    :location_uuid
  ]
end
