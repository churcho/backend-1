defmodule Core.DB.Location do
  @moduledoc false
  use Core.BaseSchema
  import Ecto.Changeset
  alias Core.Places.{
    Geocoder
  }

  @derive {Poison.Encoder, except: [:__meta__]}

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
    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [
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
      :solar_noon
    ])
    |> validate_required([])
    |> assign_coords
  end

  def assign_coords(changeset) do
    IO.puts "Geocoding"
    address = Geocoder.compose_address(changeset.params)
    coords = Geocoder.get_coords_from_address(address)

    if coords do
      tz_info = Geocoder.get_timezone_from_coords(coords)
      times = Astro.get_times(coords.lat, coords.lng)
      changes =
      cast(changeset,
      %{
        latitude: coords.lat,
        longitude: coords.lng,
        dst_offset: tz_info.dstOffset,
        timezone_id: tz_info.timeZoneId,
        raw_time_offset: tz_info.rawOffset,
        sunrise: DateTime.to_unix(times.sunrise),
        sunset: DateTime.to_unix(times.sunset)
      },
      [
        :latitude,
        :longitude,
        :dst_offset,
        :timezone_id,
        :raw_time_offset,
        :sunrise,
        :sunset
      ])
      changes
    end
  end
end


