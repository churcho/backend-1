defmodule CouchPotatoConnect do

  alias Core.ServiceManager
  alias Core.ServiceManager.Provider
  @moduledoc """
  Documentation for CouchPotato.
  """

  @doc """
  Basic Registration Information
  """
  def registration do
    %{
      name: "CouchPotato",
      description: "Media Libary",
      url: "http://couchpota.to",
      lorp_name: "CouchPotatoConnect",
      auth_method: "API_KEY",
      max_services: 1,
      version: "0.0.1",
      configuration: %{
        service_name: "CouchPotato",
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
    with {:ok, %Provider{} = provider} <- ServiceManager.create_or_update_provider(registration()) do
      provider
    end
  end


end
