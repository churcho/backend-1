defmodule Darko do
  @moduledoc """
  API Boundary for Darko.

  Darko provides virtual weather stations for a given location using data from
  the Dark Sky weather API.
  """

  require Logger
  alias Core.Services
  alias Core.DB.Provider

  @doc """
  Basic Registration Information
  """
  def registration do
    %{
      name: "Dark Sky",
      description: "Dark Sky Weather",
      url: "https://darksky.net/dev/",
      service_name: "Darko",
      auth_method: "API_KEY",
      max_services: 1,
      version: "0.0.2",
      required_fields: [
        %{key: "api_key", name: "api_key", label: "API Key", placeholder: "API Key"},
        %{key: "name", name: "name", label: "Name", placeholder: "Name"}
      ],
      commands: [
        %{name: "get_sunrise", target: "location"},
        %{name: "get_sunset", target: "location"},
        %{name: "get_current_forecast", target: "location"}
      ],
    }
  end

  @doc """
  Register the provider
  """
  def register_provider do
    new_provider = Darko.registration
    existing = Services.provider_by_service_name(new_provider.service_name)
    if  existing == nil do
      with {:ok, %Provider{} = provider} <-
        Services.register_provider(new_provider)
      do
        Logger.info fn ->
          "Provider Registered as #{provider.service_name}"
        end
        provider
      end
    else
      with {:ok, %Provider{} = provider} <-
        Services.update_provider(existing, new_provider)
      do
        Logger.info fn ->
          "#{provider.service_name} updated provider registration"
        end
        provider
      end
    end
  end
end
