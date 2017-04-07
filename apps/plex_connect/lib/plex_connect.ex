defmodule PlexConnect do
  import Ecto.Query
  alias Core.Repo
  alias Core.ServiceManager
  alias Core.ServiceManager.Provider
  @moduledoc """
  Documentation for Plex.
  """

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
        service_name: "Plex",
        required_fields: ["host", "port"]
      },
      provides: %{
        services: ["Movies", "TV Shows"]
      }
    }
  end

  @doc """
  Register the provider
  """
  def register_provider do
    with {:ok, %Provider{} = provider} <- ServiceManager.create_or_update_provider(registration) do
      IO.puts "Registered "<>provider.name
    end
  end

end