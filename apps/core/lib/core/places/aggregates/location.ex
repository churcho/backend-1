defmodule Core.Places.Aggregates.Location do
  @moduledoc false
  defstruct [
    uuid: nil,
    name: nil,
    address_one: nil,
    address_two: nil,
    address_city: nil,
    address_country: nil,
    address_state: nil,
    address_zip: nil,
    slug: nil,
    description: nil,
    latitude: nil,
    longitude: nil,
    timezone_id: nil,
    dst_offset: nil,
    raw_time_offset: nil,
    sunrise: nil,
    sunset: nil,
    day_length: nil,
    solar_noon: nil,
    location_type: nil,
    zones: nil,
    deleted?: false,
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

  alias Core.Places.Aggregates.Location
  alias Core.Places.Commands.{
    CreateLocation,
    UpdateLocation,
    DeleteLocation,
    UpdateLocationWeather
  }

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

  @doc """
  Create a new Location
  """
  def execute(%Location{uuid: nil}, %CreateLocation{} = create) do
    %LocationCreated{
      location_uuid: create.location_uuid,
      name: create.name,
      description: create.description,
      address_one: create.address_one,
      address_two: create.address_two,
      address_city: create.address_city,
      address_country: create.address_country,
      address_state: create.address_state,
      address_zip: create.address_zip,
      latitude: create.latitude,
      longitude: create.longitude,
      timezone_id: create.timezone_id,
      dst_offset: create.dst_offset,
      raw_time_offset: create.raw_time_offset,
      sunrise: create.sunrise,
      sunset: create.sunset,
      day_length: create.day_length,
      solar_noon: create.solar_noon
    }
  end

  @doc """
  Update Location Weather
  """
  def execute(
    %Location{uuid: location_uuid},
    %UpdateLocationWeather{
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
    })
  do
    %LocationWeatherUpdated{
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
    }
  end


  @doc """
  Update a location's name, description
  """
  def execute(%Location{} = location, %UpdateLocation{} = update) do
    Enum.reduce([
      &name_changed/2,
      &description_changed/2,
      &address_one_changed/2,
      &address_two_changed/2,
      &address_city_changed/2,
      &address_country_changed/2,
      &address_state_changed/2,
      &address_zip_changed/2,
      &latitude_changed/2,
      &longitude_changed/2,
      &timezone_id_changed/2,
      &dst_offset_changed/2,
      &raw_time_offset_changed/2,
      &sunrise_changed/2,
      &sunset_changed/2,
      &day_length_changed/2,
      &solar_noon_changed/2
      ], [], fn (change, events) ->
      case change.(location, update) do
        nil -> events
        event -> [event | events]
      end
    end)
  end

  @doc """
  Delete an existing Location
  """
  def execute(
    %Location{uuid: location_uuid, deleted?: false},
    %DeleteLocation{location_uuid: location_uuid})
  do
    %LocationDeleted{location_uuid: location_uuid}
  end

  @doc """
  Stop the location aggregate after it has been deleted
  """
  def after_event(%LocationDeleted{}), do: :stop
  def after_event(_), do: :timer.hours(1)

  # state mutators

  def apply(%Location{} = location, %LocationCreated{} = created) do
    %Location{location |
      uuid: created.location_uuid,
      name: created.name,
      description: created.description,
      address_one: created.address_one,
      address_two: created.address_two,
      address_city: created.address_city,
      address_country: created.address_country,
      address_state: created.address_state,
      address_zip: created.address_zip,
      latitude: created.latitude,
      longitude: created.longitude,
      timezone_id: created.timezone_id,
      dst_offset: created.dst_offset,
      raw_time_offset: created.raw_time_offset,
      sunrise: created.sunrise,
      sunset: created.sunset,
      day_length: created.day_length,
      solar_noon: created.solar_noon
    }
  end

  def apply(%Location{} = location, %LocationWeatherUpdated{} = updated) do
    %Location{location |
      weather_apparent_temperature: updated.weather_apparent_temperature,
      weather_cloud_cover: updated.weather_cloud_cover,
      weather_dew_point: updated.weather_dew_point,
      weather_humidity: updated.weather_humidity,
      weather_icon: updated.weather_icon,
      weather_nearest_storm_bearing: updated.weather_nearest_storm_bearing,
      weather_nearest_storm_distance: updated.weather_nearest_storm_distance,
      weather_ozone: updated.weather_ozone,
      weather_percipitation_intensity: updated.weather_percipitation_intensity,
      weather_percipitation_propability: updated.weather_percipitation_propability,
      weather_pressure: updated.weather_pressure,
      weather_summary: updated.weather_summary,
      weather_temperature: updated.weather_temperature,
      weather_uv_index: updated.weather_uv_index,
      weather_visibility: updated.weather_visibility,
      weather_wind_bearing: updated.weather_wind_bearing,
      weather_wind_gust: updated.weather_wind_gust,
      weather_wind_speed: updated.weather_wind_speed
    }
  end

  def apply(%Location{} = location, %LocationDeleted{}) do
    %Location{location| deleted?: true}
  end

  def apply(%Location{} = location, %LocationNameChanged{name: name}) do
    %Location{location | name: name}
  end

  def apply(%Location{} = location, %LocationDescriptionChanged{description: description}) do
    %Location{location | description: description}
  end

  def apply(%Location{} = location, %LocationAddressOneChanged{address_one: address_one}) do
    %Location{location | address_one: address_one}
  end

  def apply(%Location{} = location, %LocationAddressTwoChanged{address_two: address_two}) do
    %Location{location | address_two: address_two}
  end

  def apply(%Location{} = location, %LocationAddressCityChanged{address_city: address_city}) do
    %Location{location | address_city: address_city}
  end

  def apply(%Location{} = location, %LocationAddressCountryChanged{address_country: address_country}) do
    %Location{location | address_country: address_country}
  end

  def apply(%Location{} = location, %LocationAddressStateChanged{address_state: address_state}) do
    %Location{location | address_state: address_state}
  end

  def apply(%Location{} = location, %LocationAddressZipChanged{address_zip: address_zip}) do
    %Location{location | address_zip: address_zip}
  end

  def apply(%Location{} = location, %LocationLatitudeChanged{latitude: latitude}) do
    %Location{location | latitude: latitude}
  end

  def apply(%Location{} = location, %LocationLongitudeChanged{longitude: longitude}) do
    %Location{location | longitude: longitude}
  end

  def apply(%Location{} = location, %LocationTimezoneIdChanged{timezone_id: timezone_id}) do
    %Location{location | timezone_id: timezone_id}
  end

  def apply(%Location{} = location, %LocationDstOffsetChanged{dst_offset: dst_offset}) do
    %Location{location | dst_offset: dst_offset}
  end

  def apply(%Location{} = location, %LocationRawTimeOffsetChanged{raw_time_offset: raw_time_offset}) do
    %Location{location | raw_time_offset: raw_time_offset}
  end

  def apply(%Location{} = location, %LocationSunriseChanged{sunrise: sunrise}) do
    %Location{location | sunrise: sunrise}
  end

  def apply(%Location{} = location, %LocationSunsetChanged{sunset: sunset}) do
    %Location{location | sunset: sunset}
  end

  def apply(%Location{} = location, %LocationDayLengthChanged{day_length: day_length}) do
    %Location{location | day_length: day_length}
  end

  def apply(%Location{} = location, %LocationSolarNoonChanged{solar_noon: solar_noon}) do
    %Location{location | solar_noon: solar_noon}
  end

  # private helpers

  defp name_changed(%Location{}, %UpdateLocation{name: ""}), do: nil
  defp name_changed(%Location{name: name}, %UpdateLocation{name: name}), do: nil
  defp name_changed(%Location{uuid: location_uuid}, %UpdateLocation{name: name}) do
    %LocationNameChanged{
      location_uuid: location_uuid,
      name: name,
    }
  end

  defp description_changed(%Location{}, %UpdateLocation{description: ""}), do: nil
  defp description_changed(%Location{description: description}, %UpdateLocation{description: description}), do: nil
  defp description_changed(%Location{uuid: location_uuid}, %UpdateLocation{description: description}) do
    %LocationDescriptionChanged{
      location_uuid: location_uuid,
      description: description,
    }
  end

  defp address_one_changed(%Location{}, %UpdateLocation{address_one: ""}), do: nil
  defp address_one_changed(%Location{address_one: address_one}, %UpdateLocation{address_one: address_one}), do: nil
  defp address_one_changed(%Location{uuid: location_uuid}, %UpdateLocation{address_one: address_one}) do
    %LocationAddressOneChanged{
      location_uuid: location_uuid,
      address_one: address_one,
    }
  end

  defp address_two_changed(%Location{}, %UpdateLocation{address_two: ""}), do: nil
  defp address_two_changed(%Location{address_two: address_two}, %UpdateLocation{address_two: address_two}), do: nil
  defp address_two_changed(%Location{uuid: location_uuid}, %UpdateLocation{address_two: address_two}) do
    %LocationAddressTwoChanged{
      location_uuid: location_uuid,
      address_two: address_two,
    }
  end

  defp address_city_changed(%Location{}, %UpdateLocation{address_city: ""}), do: nil
  defp address_city_changed(%Location{address_city: address_city}, %UpdateLocation{address_city: address_city}), do: nil
  defp address_city_changed(%Location{uuid: location_uuid}, %UpdateLocation{address_city: address_city}) do
    %LocationAddressCityChanged{
      location_uuid: location_uuid,
      address_city: address_city,
    }
  end

  defp address_country_changed(%Location{}, %UpdateLocation{address_country: ""}), do: nil
  defp address_country_changed(%Location{address_country: address_country}, %UpdateLocation{address_country: address_country}), do: nil
  defp address_country_changed(%Location{uuid: location_uuid}, %UpdateLocation{address_country: address_country}) do
    %LocationAddressCountryChanged{
      location_uuid: location_uuid,
      address_country: address_country,
    }
  end

  defp address_state_changed(%Location{}, %UpdateLocation{address_state: ""}), do: nil
  defp address_state_changed(%Location{address_state: address_state}, %UpdateLocation{address_state: address_state}), do: nil
  defp address_state_changed(%Location{uuid: location_uuid}, %UpdateLocation{address_state: address_state}) do
    %LocationAddressStateChanged{
      location_uuid: location_uuid,
      address_state: address_state,
    }
  end

  defp address_zip_changed(%Location{}, %UpdateLocation{address_zip: ""}), do: nil
  defp address_zip_changed(%Location{address_zip: address_zip}, %UpdateLocation{address_zip: address_zip}), do: nil
  defp address_zip_changed(%Location{uuid: location_uuid}, %UpdateLocation{address_zip: address_zip}) do
    %LocationAddressZipChanged{
      location_uuid: location_uuid,
      address_zip: address_zip,
    }
  end

  defp latitude_changed(%Location{}, %UpdateLocation{latitude: ""}), do: nil
  defp latitude_changed(%Location{latitude: latitude}, %UpdateLocation{latitude: latitude}), do: nil
  defp latitude_changed(%Location{uuid: location_uuid}, %UpdateLocation{latitude: latitude}) do
    %LocationLatitudeChanged{
      location_uuid: location_uuid,
      latitude: latitude,
    }
  end

  defp longitude_changed(%Location{}, %UpdateLocation{longitude: ""}), do: nil
  defp longitude_changed(%Location{longitude: longitude}, %UpdateLocation{longitude: longitude}), do: nil
  defp longitude_changed(%Location{uuid: location_uuid}, %UpdateLocation{longitude: longitude}) do
    %LocationLongitudeChanged{
      location_uuid: location_uuid,
      longitude: longitude,
    }
  end

  defp timezone_id_changed(%Location{}, %UpdateLocation{timezone_id: ""}), do: nil
  defp timezone_id_changed(%Location{timezone_id: timezone_id}, %UpdateLocation{timezone_id: timezone_id}), do: nil
  defp timezone_id_changed(%Location{uuid: location_uuid}, %UpdateLocation{timezone_id: timezone_id}) do
    %LocationTimezoneIdChanged{
      location_uuid: location_uuid,
      timezone_id: timezone_id,
    }
  end

  defp dst_offset_changed(%Location{}, %UpdateLocation{dst_offset: ""}), do: nil
  defp dst_offset_changed(%Location{dst_offset: dst_offset}, %UpdateLocation{dst_offset: dst_offset}), do: nil
  defp dst_offset_changed(%Location{uuid: location_uuid}, %UpdateLocation{dst_offset: dst_offset}) do
    %LocationDstOffsetChanged{
      location_uuid: location_uuid,
      dst_offset: dst_offset,
    }
  end

  defp raw_time_offset_changed(%Location{}, %UpdateLocation{raw_time_offset: ""}), do: nil
  defp raw_time_offset_changed(%Location{raw_time_offset: raw_time_offset}, %UpdateLocation{raw_time_offset: raw_time_offset}), do: nil
  defp raw_time_offset_changed(%Location{uuid: location_uuid}, %UpdateLocation{raw_time_offset: raw_time_offset}) do
    %LocationRawTimeOffsetChanged{
      location_uuid: location_uuid,
      raw_time_offset: raw_time_offset,
    }
  end

  defp sunrise_changed(%Location{}, %UpdateLocation{sunrise: ""}), do: nil
  defp sunrise_changed(%Location{sunrise: sunrise}, %UpdateLocation{sunrise: sunrise}), do: nil
  defp sunrise_changed(%Location{uuid: location_uuid}, %UpdateLocation{sunrise: sunrise}) do
    %LocationSunriseChanged{
      location_uuid: location_uuid,
      sunrise: sunrise,
    }
  end

  defp sunset_changed(%Location{}, %UpdateLocation{sunset: ""}), do: nil
  defp sunset_changed(%Location{sunset: sunset}, %UpdateLocation{sunset: sunset}), do: nil
  defp sunset_changed(%Location{uuid: location_uuid}, %UpdateLocation{sunset: sunset}) do
    %LocationSunsetChanged{
      location_uuid: location_uuid,
      sunset: sunset,
    }
  end

  defp day_length_changed(%Location{}, %UpdateLocation{day_length: ""}), do: nil
  defp day_length_changed(%Location{day_length: day_length}, %UpdateLocation{day_length: day_length}), do: nil
  defp day_length_changed(%Location{uuid: location_uuid}, %UpdateLocation{day_length: day_length}) do
    %LocationDayLengthChanged{
      location_uuid: location_uuid,
      day_length: day_length,
    }
  end

  defp solar_noon_changed(%Location{}, %UpdateLocation{solar_noon: ""}), do: nil
  defp solar_noon_changed(%Location{solar_noon: solar_noon}, %UpdateLocation{solar_noon: solar_noon}), do: nil
  defp solar_noon_changed(%Location{uuid: location_uuid}, %UpdateLocation{solar_noon: solar_noon}) do
    %LocationSolarNoonChanged{
      location_uuid: location_uuid,
      solar_noon: solar_noon,
    }
  end

end
