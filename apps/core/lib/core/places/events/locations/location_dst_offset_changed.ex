defmodule Core.Places.Events.LocationDstOffsetChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :location_uuid,
    :dst_offset
  ]
end
