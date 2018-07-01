defmodule Core.Places.Events.LocationLatitudeChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :location_uuid,
    :latitude
  ]
end
