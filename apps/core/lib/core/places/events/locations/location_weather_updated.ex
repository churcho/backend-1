defmodule Core.Places.Events.LocationWeatherUpdated do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :location_uuid,
    :weather_apparent_temperature,
    :weather_cloud_cover,
    :weather_dew_point,
    :weather_humidity,
    :weather_icon,
    :weather_nearest_storm_bearing,
    :weather_nearest_storm_distance,
    :weather_ozone,
    :weather_percipitation_intensity,
    :weather_percipitation_propability,
    :weather_pressure,
    :weather_summary,
    :weather_temperature,
    :weather_uv_index,
    :weather_visibility,
    :weather_wind_bearing,
    :weather_wind_gust,
    :weather_wind_speed
  ]
end
