defmodule Core.Places.Geocoder do
   @moduledoc """
  Geocoding helper
  """
  use HTTPoison.Base
  alias Core.Places.Geocoder



  def get_coords_from_address(address) do
    api_key = Application.get_env(:core, :google_geo_api_key)
    url = "https://maps.googleapis.com/maps/api/geocode/json?address="
    {:ok, result} = Geocoder.get(url <> address <> "&key=" <> api_key)

    final =
      result.body
      |> Poison.decode!(keys: :atoms)

    loc = Enum.at(final.results, 0)
    loc.geometry.location
  end

  def get_timezone_from_coords(coords) do
    api_key = Application.get_env(:core, :google_geo_api_key)
    url = "https://maps.googleapis.com/maps/api/timezone/json?location="
    {:ok, result} = Geocoder.get("#{url}#{coords.lat},#{coords.lng}&timestamp=1530707584&key=#{api_key}")

    final =
      result.body
      |> Poison.decode!(keys: :atoms)

    final
  end


  def compose_address(location) do
    if location.address_one && location.address_city && location.address_state &&
         location.address_zip do
      URI.encode(
        location.address_one <>
          " + , + " <>
          location.address_city <>
          " + , + " <> location.address_state <> " + , + " <> location.address_zip
      )
    end
  end
end
