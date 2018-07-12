defmodule Core.Places.Events.LocationSunsetChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :location_uuid,
    :sunset
  ]
end
