defmodule Core.Places.Events.LocationCreated do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :location_uuid,
    :name,
    :address_one,
    :address_two,
    :address_city,
    :address_country,
    :address_state,
    :address_zip,
    :slug,
    :description,
    :latitude,
    :longitude,
    :location_type,
    :zones
  ]
end
