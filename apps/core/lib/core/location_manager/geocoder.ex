defmodule Core.Geocoder do
  @moduledoc """
  Geocoding helper
  """
  use HTTPoison.Base
  alias Core.Geocoder

  def get_coords(address, api_key) do
    url = "https://maps.googleapis.com/maps/api/geocode/json?address="
    {:ok, result} = Geocoder.get(url <> address <> "&key=" <> api_key)

    final =
      result.body
      |> Poison.decode!(keys: :atoms)

    loc = Enum.at(final.results, 0)
    loc.geometry.location
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
