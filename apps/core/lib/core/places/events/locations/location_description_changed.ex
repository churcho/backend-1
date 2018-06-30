defmodule Core.Places.Events.LocationDescriptionChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :location_uuid,
    :description
  ]
end
