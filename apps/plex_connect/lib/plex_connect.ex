defmodule PlexConnect do
  @moduledoc """
  Documentation for Plex.
  """

  require Logger
  alias Core.ProviderManager
  alias Core.ProviderManager.Provider


  @doc """
  Basic Registration Information
  """
  def registration do
    %{
      name: "Plex",
      description: "Media Libary",
      url: "http://plex.tv",
      lorp_name: "PlexConnect",
      auth_method: "API_KEY",
      max_services: 1,
      version: "0.0.1",
      configuration: %{
        service_name: "PlexConnect",
        required_fields: ["host", "port"]
      },
      metadata: %{

      },
      provides: [
        %{service: "movie_playback"}
      ]
    }
  end

  @doc """
  Register the provider
  """
  def register_provider do
    with {:ok, %Provider{} = provider} <- ProviderManager.create_or_update_provider(PlexConnect.registration) do
      Logger.info fn ->
        "Provider Registered as #{provider.lorp_name}"
      end
      provider
    end
  end

end
