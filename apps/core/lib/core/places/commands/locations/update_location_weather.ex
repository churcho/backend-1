defmodule Core.Places.Commands.UpdateLocationWeather do
  @moduledoc """
  Command to update location
  """

  defstruct [
    location_uuid: "",
    weather_apparent_temperature: nil,
    weather_cloud_cover: nil,
    weather_dew_point: nil,
    weather_humidity: nil,
    weather_icon: nil,
    weather_nearest_storm_bearing: nil,
    weather_nearest_storm_distance: nil,
    weather_ozone: nil,
    weather_percipitation_intensity: nil,
    weather_percipitation_propability: nil,
    weather_pressure: nil,
    weather_summary: "",
    weather_temperature: nil,
    weather_uv_index: nil,
    weather_visibility: nil,
    weather_wind_bearing: nil,
    weather_wind_gust: nil,
    weather_wind_speed: nil
  ]

  use ExConstructor
  use Vex.Struct

  alias Core.Places.Commands.UpdateLocationWeather
  alias Core.Places.Projections.Location


  validates :location_uuid, uuid: true

  @doc """
  Assign the Location identity
  """
  def assign_location(%UpdateLocationWeather{} = update_location, %Location{uuid: location_uuid}) do
    %UpdateLocationWeather{update_location | location_uuid: location_uuid}
  end

  def update_weather(%UpdateLocationWeather{} = update_location) do
    %UpdateLocationWeather{update_location |
      weather_apparent_temperature: update_location.weather_apparent_temperature,
      weather_cloud_cover: update_location.weather_cloud_cover,
      weather_dew_point: update_location.weather_dew_point,
      weather_humidity: update_location.weather_humidity,
      weather_icon: update_location.weather_icon,
      weather_nearest_storm_bearing: update_location.weather_nearest_storm_bearing,
      weather_nearest_storm_distance: update_location.weather_nearest_storm_distance,
      weather_ozone: update_location.weather_ozone,
      weather_percipitation_intensity: update_location.weather_percipitation_intensity,
      weather_percipitation_propability: update_location.weather_percipitation_propability,
      weather_pressure: update_location.weather_pressure,
      weather_summary: update_location.weather_summary,
      weather_temperature: update_location.weather_temperature,
      weather_uv_index: update_location.weather_uv_index,
      weather_visibility: update_location.weather_visibility,
      weather_wind_bearing: update_location.weather_wind_bearing,
      weather_wind_gust: update_location.weather_wind_gust,
      weather_wind_speed: update_location.weather_wind_speed

    }
  end

end
