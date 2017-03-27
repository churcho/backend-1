defmodule Geocoder do
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
      name: "Geocoder (Google)",
      description: "Geocodes!",
      url: "http://www.google.com",
      lorp_name: "Geocoder",
      auth_method: "API_KEY",
      max_services: 1,
      version: "0.0.1",
      configuration: %{
        service_name: "Geocoder"
      },
      provides: %{
        services: ["Geocoding"]
      }
    }
  end

  @doc """
  Register the provider
  """
  def register_provider do

     result = 
      case Repo.get_by(Provider, lorp_name: Geocoder.registration.lorp_name) do
        nil -> Provider.changeset(%Provider{}, Geocoder.registration)
        provider -> Provider.changeset(provider, Geocoder.registration)
      end
      |> Repo.insert_or_update
  end


end
