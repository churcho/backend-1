defmodule CouchPotatoConnect do
  @moduledoc """
  Documentation for CouchPotato.
  """

  require Logger
  alias Core.ServiceManager
  alias Core.ServiceManager.Provider


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
        service_name: "CouchPotatoConnect",
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
    with {:ok, %Provider{} = provider} <- ServiceManager.create_or_update_provider(CouchPotatoConnect.registration) do
      Logger.info fn ->
        "Provider Registered as #{provider.lorp_name}"
      end
      provider
    end
  end


end
