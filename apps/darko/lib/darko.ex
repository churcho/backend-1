defmodule Darko do
  @moduledoc """
  API Boundary for Darko.

  Darko provides virtual weather stations for a given location using data from
  the Dark Sky weather API.
  """

  require Logger
  alias Core.ProviderManager
  alias Core.ProviderManager.Provider


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
      provides: [
        %{service: "weather"}
      ]
    }
  end

  @doc """
  Register the provider
  """
  def register_provider do
    with {:ok, %Provider{} = provider} <- ProviderManager.create_or_update_provider(Darko.registration) do
      Logger.info fn ->
        "Provider Registered as #{provider.lorp_name}"
      end
      provider
    end
  end
end
