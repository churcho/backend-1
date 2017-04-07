defmodule Darko do
  alias Core.ServiceManager
  alias Core.ServiceManager.Provider
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
    with {:ok, %Provider{} = provider} <- ServiceManager.create_or_update_provider(Darko.registration) do
      provider
    end
  end


end
