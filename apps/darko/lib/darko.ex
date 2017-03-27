defmodule Darko do
  import Ecto.Query
  alias Core.Repo
  alias Core.Provider
  @moduledoc """
  Documentation for Geocoder.
  """

  @doc """
  Basic Registration Information
  """
  def registration do
    %{
      name: "Dark Sky",
      description: "The Dark Sky Company specializes in weather forecasting and visualization. ",
      url: "https://darksky.net/dev/",
      lorp_name: "Darko",
      auth_method: "API_KEY",
      max_services: 1,
      version: "0.0.1",
      configuration: %{
        service_name: "Darko"
      },
      provides: %{
        services: ["WeatherStation"]
      }
    }
  end

  @doc """
  Register the provider
  """
  def register_provider do
     result = 
      case Repo.get_by(Provider, lorp_name: Darko.registration.lorp_name) do
        nil -> Provider.changeset(%Provider{}, Darko.registration)
        provider -> Provider.changeset(provider, Darko.registration)
      end
      |> Repo.insert_or_update
  end


end