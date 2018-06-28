defmodule Core.Places.Events.LocationAddressCountryChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :location_uuid,
    :address_country,
  ]
end
