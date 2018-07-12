defmodule Core.Repo.Migrations.AddWeatherToLocation do
  @moduledoc false
  use Ecto.Migration

  def change do
    alter table("locations") do
      add(:weather_units, :string)
      add(:weather_apparent_temperature, :float)
      add(:weather_cloud_cover, :float)
      add(:weather_dew_point, :float)
      add(:weather_humidity, :float)
      add(:weather_icon, :string)
      add(:weather_nearest_storm_bearing, :integer)
      add(:weather_nearest_storm_distance, :integer)
      add(:weather_ozone, :float)
      add(:weather_percipitation_intensity, :float)
      add(:weather_percipitation_propability, :integer)
      add(:weather_pressure, :float)
      add(:weather_summary, :string)
      add(:weather_temperature, :float)
      add(:weather_uv_index, :integer)
      add(:weather_visibility, :float)
      add(:weather_wind_bearing, :integer)
      add(:weather_wind_gust, :float)
      add(:weather_wind_speed, :float)
    end
  end
end
