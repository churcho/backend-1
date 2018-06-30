defmodule Core.Places.Events.ZoneDescriptionChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :zone_uuid,
    :description
  ]
end
