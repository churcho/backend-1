defmodule Core.Places.Events.LocationRawTimeOffsetChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :location_uuid,
    :raw_time_offset
  ]
end
