defmodule SonarrConnect do

  alias Core.ServiceManager
  alias Core.ServiceManager.Provider
  @moduledoc """
  Documentation for Sonarr.
  """

  @doc """
  Basic Registration Information
  """
  def registration do
    %{
      name: "Sonarr",
      description: "Internet DVR for TV",
      url: "http://sonarr.tv",
      lorp_name: "SonarrConnect",
      auth_method: "API_KEY",
      max_services: 1,
      version: "0.0.1",
      configuration: %{
        service_name: "Sonarr",
        required_fields: ["host", "port"]
      },
      provides: %{
        services: ["TV"]
      }
    }
  end

  @doc """
  Register the provider
  """
  def register_provider do
    with {:ok, %Provider{} = provider} <- ServiceManager.create_or_update_provider(registration()) do
      provider
    end
  end

end
