defmodule Core.Places.Events.LocationLongitudeChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :location_uuid,
    :longitude
  ]
end
