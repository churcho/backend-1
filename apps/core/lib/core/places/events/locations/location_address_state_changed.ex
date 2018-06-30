defmodule Core.Places.Events.LocationAddressStateChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :location_uuid,
    :address_state,
  ]
end
