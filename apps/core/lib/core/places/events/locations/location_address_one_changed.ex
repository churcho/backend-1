defmodule Core.Places.Events.LocationAddressOneChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :location_uuid,
    :address_one,
  ]
end
