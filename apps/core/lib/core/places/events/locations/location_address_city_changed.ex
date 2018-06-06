defmodule Core.Places.Events.LocationAddressCityChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :location_uuid,
    :address_city,
  ]
end
