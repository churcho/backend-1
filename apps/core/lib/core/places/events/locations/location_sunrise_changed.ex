defmodule Core.Places.Events.LocationSunriseChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :location_uuid,
    :sunrise
  ]
end
