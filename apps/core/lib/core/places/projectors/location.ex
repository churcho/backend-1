defmodule Core.Places.Projectors.Location do
  @moduledoc false
  use Commanded.Projections.Ecto,
    name: "Places.Projectors.Location",
    consistency: :strong

  alias Core.Places.Events.{
    LocationCreated,
    LocationDeleted,
    LocationNameChanged,
    LocationDescriptionChanged,
    LocationAddressOneChanged,
    LocationAddressTwoChanged,
    LocationAddressCityChanged,
    LocationAddressCountryChanged,
    LocationAddressStateChanged,
    LocationAddressZipChanged,
    LocationLatitudeChanged,
    LocationLongitudeChanged,
    LocationTimezoneIdChanged,
    LocationDstOffsetChanged,
    LocationRawTimeOffsetChanged,
    LocationSunriseChanged,
    LocationSunsetChanged,
    LocationDayLengthChanged,
    LocationSolarNoonChanged,
    LocationWeatherUpdated
  }
  alias Core.Places.Projections.Location
  alias Ecto.Multi

  project %LocationCreated{} = created do
    Multi.insert(multi, :location, %Location{
      uuid: created.location_uuid,
      name: created.name,
      description: created.description,
      address_one: created.address_one,
      address_two: created.address_two,
      address_city: created.address_city,
      address_country: created.address_country,
      address_state: created.address_state,
      address_zip: created.address_zip,
      longitude: created.longitude,
      latitude: created.latitude,
      timezone_id: created.timezone_id,
      dst_offset: created.dst_offset,
      raw_time_offset: created.raw_time_offset,
      sunrise: created.sunrise,
      sunset: created.sunset,
      day_length: created.day_length,
      solar_noon: created.solar_noon
    })
  end

  project %LocationNameChanged{location_uuid: location_uuid, name: name} do
    update_location(multi, location_uuid, name: name)
  end

  project %LocationDescriptionChanged{
    location_uuid: location_uuid, description: description}
  do
    update_location(multi, location_uuid, description: description)
  end

  project %LocationAddressOneChanged{
    location_uuid: location_uuid, address_one: address_one}
  do
    update_location(multi, location_uuid, address_one: address_one)
  end

  project %LocationAddressTwoChanged{
    location_uuid: location_uuid, address_two: address_two}
  do
    update_location(multi, location_uuid, address_two: address_two)
  end

  project %LocationAddressCityChanged{
    location_uuid: location_uuid, address_city: address_city}
  do
    update_location(multi, location_uuid, address_city: address_city)
  end

  project %LocationAddressCountryChanged{
    location_uuid: location_uuid, address_country: address_country}
  do
    update_location(multi, location_uuid, address_country: address_country)
  end

  project %LocationAddressStateChanged{
    location_uuid: location_uuid, address_state: address_state}
  do
    update_location(multi, location_uuid, address_state: address_state)
  end

  project %LocationAddressZipChanged{
    location_uuid: location_uuid, address_zip: address_zip}
  do
    update_location(multi, location_uuid, address_zip: address_zip)
  end

  project %LocationLongitudeChanged{
    location_uuid: location_uuid, longitude: longitude}
  do
    update_location(multi, location_uuid, longitude: longitude)
  end

  project %LocationLatitudeChanged{
    location_uuid: location_uuid, latitude: latitude}
  do
    update_location(multi, location_uuid, latitude: latitude)
  end

  project %LocationTimezoneIdChanged{
    location_uuid: location_uuid, timezone_id: timezone_id}
  do
    update_location(multi, location_uuid, timezone_id: timezone_id)
  end

  project %LocationDstOffsetChanged{
    location_uuid: location_uuid, dst_offset: dst_offset}
  do
    update_location(multi, location_uuid, dst_offset: dst_offset)
  end

  project %LocationRawTimeOffsetChanged{
    location_uuid: location_uuid, raw_time_offset: raw_time_offset}
  do
    update_location(multi, location_uuid, raw_time_offset: raw_time_offset)
  end

  project %LocationSunriseChanged{
    location_uuid: location_uuid, sunrise: sunrise}
  do
    update_location(multi, location_uuid, sunrise: sunrise)
  end

  project %LocationSunsetChanged{
    location_uuid: location_uuid, sunset: sunset}
  do
    update_location(multi, location_uuid, sunset: sunset)
  end

  project %LocationDayLengthChanged{
    location_uuid: location_uuid, day_length: day_length}
  do
    update_location(multi, location_uuid, day_length: day_length)
  end

  project %LocationSolarNoonChanged{
    location_uuid: location_uuid, solar_noon: solar_noon}
  do
    update_location(multi, location_uuid, solar_noon: solar_noon)
  end

  project %LocationDeleted{location_uuid: location_uuid} do
    Multi.delete_all(multi, :location, location_query(location_uuid))
  end

  project %LocationWeatherUpdated{
    location_uuid: location_uuid,
    weather_apparent_temperature: weather_apparent_temperature,
    weather_cloud_cover: weather_cloud_cover,
    weather_dew_point: weather_dew_point,
    weather_humidity: weather_humidity,
    weather_icon: weather_icon,
    weather_nearest_storm_bearing: weather_nearest_storm_bearing,
    weather_nearest_storm_distance: weather_nearest_storm_distance,
    weather_ozone: weather_ozone,
    weather_percipitation_intensity: weather_percipitation_intensity,
    weather_percipitation_propability: weather_percipitation_propability,
    weather_pressure: weather_pressure,
    weather_summary: weather_summary,
    weather_temperature: weather_temperature,
    weather_uv_index: weather_uv_index,
    weather_visibility: weather_visibility,
    weather_wind_bearing: weather_wind_bearing,
    weather_wind_gust: weather_wind_gust,
    weather_wind_speed: weather_wind_speed
  } do
    update_location(
      multi,
      location_uuid,
      weather_apparent_temperature: weather_apparent_temperature,
      weather_cloud_cover: weather_cloud_cover,
      weather_dew_point: weather_dew_point,
      weather_humidity: weather_humidity,
      weather_icon: weather_icon,
      weather_nearest_storm_bearing: weather_nearest_storm_bearing,
      weather_nearest_storm_distance: weather_nearest_storm_distance,
      weather_ozone: weather_ozone,
      weather_percipitation_intensity: weather_percipitation_intensity,
      weather_percipitation_propability: weather_percipitation_propability,
      weather_pressure: weather_pressure,
      weather_summary: weather_summary,
      weather_temperature: weather_temperature,
      weather_uv_index: weather_uv_index,
      weather_visibility: weather_visibility,
      weather_wind_bearing: weather_wind_bearing,
      weather_wind_gust: weather_wind_gust,
      weather_wind_speed: weather_wind_speed
    )
  end

  defp update_location(multi, location_uuid, changes) do
    Multi.update_all(
      multi, :location, location_query(location_uuid), set: changes
      )
  end

  defp location_query(location_uuid) do
    from(l in Location, where: l.uuid == ^location_uuid)
  end
end
