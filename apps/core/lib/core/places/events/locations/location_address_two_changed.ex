defmodule Core.Places.Events.LocationAddressTwoChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :location_uuid,
    :address_two,
  ]
end
