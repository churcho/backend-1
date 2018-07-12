defmodule CoreWeb.LocationView do
  use CoreWeb, :view

  def render("index.json", %{locations: locations}) do
    %{
      links: %{self: "/api/v1/places/locations"},
      data: render_many(locations, CoreWeb.LocationView, "location.json")
    }
  end

  def render("show.json", %{location: location}) do
    %{
      data: render_one(location, CoreWeb.LocationView, "location.json")
    }
  end

  def render("location.json", %{location: location}) do
    %{
      links: %{
        self: "/api/v1/places/locations/#{location.uuid}"
      },
      uuid: location.uuid,
      name: location.name,
      description: location.description,
      address_one: location.address_one,
      address_two: location.address_two,
      address_city: location.address_city,
      address_state: location.address_state,
      address_zip: location.address_zip,
      latitude: location.latitude,
      longitude: location.longitude,
      dst_offset: location.dst_offset,
      raw_time_offset: location.raw_time_offset,
      sunrise: location.sunrise,
      sunset: location.sunset,
      weather: %{
        apparent_temperature: location.weather_apparent_temperature,
        cloud_cover: location.weather_cloud_cover,
        dew_point: location.weather_dew_point,
        humidity: location.weather_humidity,
        icon: location.weather_icon,
        nearest_storm_bearing: location.weather_nearest_storm_bearing,
        nearest_strom_distance: location.weather_nearest_storm_distance,
        ozone: location.weather_ozone,
        pecipitation_intensity: location.weather_percipitation_intensity,
        pecipitation_propability: location.weather_percipitation_propability,
        pressure: location.weather_pressure,
        summary: location.weather_summary,
        temperature: location.weather_temperature,
        uv_index: location.weather_uv_index,
        visibility: location.weather_visibility,
        wind_bearing: location.weather_wind_bearing,
        wind_gust: location.weather_wind_gust,
        wind_speed: location.weather_wind_speed
      }
    }
end
end
