defmodule Core.Places.Events.ZoneCreated do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :zone_uuid,
    :name,
    :description,
    :location_uuid
  ]
end
