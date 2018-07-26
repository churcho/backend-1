defmodule Darko.Poller do
  require Logger
  alias Darko.Client
  @moduledoc """
  Polling the darksky service to update your virutal weather stations.
  """

  @doc """
  Simple function to grab the latest weather and update a corresponding station
  """
  def poll(service, location) do
    currently = fetch_currently(location.latitude, location.longitude, service.api_key)

    server_state = %{
      weather_apparent_temperature: location.weather_apparent_temperature,
      weather_cloud_cover: location.weather_cloud_cover,
      weather_dew_point:  location.weather_dew_point,
      weather_humidity:  location.weather_humidity,
      weather_icon:  location.weather_icon,
      weather_nearest_storm_bearing:  location.weather_nearest_storm_bearing,
      weather_nearest_storm_distance:  location.weather_nearest_storm_distance,
      weather_ozone:  location.weather_ozone,
      weather_percipitation_intensity:  location.weather_percipitation_intensity,
      weather_percipitation_propability:  location.weather_percipitation_propability,
      weather_pressure:  location.weather_pressure,
      weather_summary:  location.weather_summary,
      weather_temperature:  location.weather_temperature,
      weather_uv_index:  location.weather_uv_index,
      weather_visibility:  location.weather_visibility,
      weather_wind_bearing:  location.weather_wind_bearing,
      weather_wind_gust:  location.weather_wind_gust,
      weather_wind_speed:  location.weather_wind_speed,
    }

    net_state = %{
      weather_apparent_temperature: currently["currently"]["apparentTemperature"],
      weather_cloud_cover: currently["currently"]["cloudCover"],
      weather_dew_point: currently["currently"]["dewPoint"],
      weather_humidity: currently["currently"]["humidity"],
      weather_icon: currently["currently"]["icon"],
      weather_nearest_storm_bearing: currently["currently"]["nearestStormBearing"],
      weather_nearest_storm_distance: currently["currently"]["nearestStormDistance"],
      weather_ozone:  currently["currently"]["ozone"],
      weather_percipitation_intensity: currently["currently"]["precipIntensity"],
      weather_percipitation_propability: currently["currently"]["precipProbability"],
      weather_pressure: currently["currently"]["pressure"],
      weather_summary: currently["currently"]["summary"],
      weather_temperature: currently["currently"]["temperature"],
      weather_uv_index: currently["currently"]["uvIndex"],
      weather_visibility: currently["currently"]["visibility"],
      weather_wind_bearing: currently["currently"]["windBearing"],
      weather_wind_gust: currently["currently"]["windGust"],
      weather_wind_speed: currently["currently"]["windSpeed"]
    }


    if server_state != net_state do
      Darko.Server.clear_state()
      Darko.Server.build_state()
    end

  end

  def fetch_currently(lat, long, api_key) do
    {:ok, result} = Client.forecast(lat, long, api_key)
    Logger.info fn ->
      "Fetching current weather"
    end
    result
  end
end
