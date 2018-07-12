defmodule Core.Places.Events.LocationDayLengthChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :location_uuid,
    :day_length
  ]
end
