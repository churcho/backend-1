defmodule Core.Places.Events.LocationNameChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :location_uuid,
    :name,
  ]
end
