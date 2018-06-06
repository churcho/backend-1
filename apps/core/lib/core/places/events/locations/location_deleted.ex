defmodule Core.Places.Events.LocationDeleted do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :location_uuid
  ]
end
