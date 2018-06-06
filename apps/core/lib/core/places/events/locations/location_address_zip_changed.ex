defmodule Core.Places.Events.LocationAddressZipChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :location_uuid,
    :address_zip,
  ]
end
