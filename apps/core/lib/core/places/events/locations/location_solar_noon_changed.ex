defmodule Core.Places.Events.LocationSolarNoonChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :location_uuid,
    :solar_noon
  ]
end
