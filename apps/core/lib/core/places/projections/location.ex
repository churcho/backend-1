defmodule Core.Places.Projections.Location do
  @moduledoc false
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}
  schema "locations" do
    field(:name, :string)
    field(:address_one, :string)
    field(:address_two, :string)
    field(:address_city, :string)
    field(:address_country, :string)
    field(:address_state, :string)
    field(:address_zip, :string)
    field(:slug, :string)
    field(:description, :string)
    field(:latitude, :float)
    field(:longitude, :float)
    field(:timezone_id, :string)
    field(:dst_offset, :integer)
    field(:raw_time_offset, :integer)
    field(:sunrise, :integer)
    field(:sunset, :integer)
    field(:day_length, :integer)
    field(:solar_noon, :integer)
    field(:location_type_uuid, :binary_id)
    field(:zones, {:array, :binary_id}, default: [])
    field(:weather_units, :string)
    field(:weather_apparent_temperature, :float)
    field(:weather_cloud_cover, :float)
    field(:weather_dew_point, :float)
    field(:weather_humidity, :float)
    field(:weather_icon, :string)
    field(:weather_nearest_storm_bearing, :integer)
    field(:weather_nearest_storm_distance, :integer)
    field(:weather_ozone, :float)
    field(:weather_percipitation_intensity, :float)
    field(:weather_percipitation_propability, :integer)
    field(:weather_pressure, :float)
    field(:weather_summary, :string)
    field(:weather_temperature, :float)
    field(:weather_uv_index, :integer)
    field(:weather_visibility, :float)
    field(:weather_wind_bearing, :integer)
    field(:weather_wind_gust, :float)
    field(:weather_wind_speed, :float)
    timestamps()
  end
end
