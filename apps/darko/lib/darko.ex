defmodule Darko do
  @moduledoc """
  API Boundary for Darko.

  Darko provides virtual weather stations for a given location using data from
  the Dark Sky weather API.
  """
  alias Core.ServiceManager
  alias Core.ServiceManager.Provider

  
  @doc """
  Basic Registration Information
  """
  def registration do
    %{
      name: "Dark Sky",
      description: "Dark Sky Weather",
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
