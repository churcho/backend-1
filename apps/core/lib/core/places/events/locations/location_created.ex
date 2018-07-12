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
    :timezone_id,
    :dst_offset,
    :raw_time_offset,
    :sunrise,
    :sunset,
    :day_length,
    :solar_noon,
    :location_type,
    :zones
  ]
end
