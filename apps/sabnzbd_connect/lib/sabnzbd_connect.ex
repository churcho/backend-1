defmodule SabnzbdConnect do
  @moduledoc """
  SabnzbdConnect
  """

  require Logger
  alias Core.ServiceManager
  alias Core.ServiceManager.Provider


  @doc """
  Basic Registration Information
  """
  def registration do
    %{
      name: "Sabnzbd",
      description: "NZB Manager",
      url: "http://sabnzbd.org",
      lorp_name: "SabnzbdConnect",
      auth_method: "API_KEY",
      max_services: 1,
      version: "0.0.1",
      configuration: %{
        service_name: "Sabnzbd",
        required_fields: ["host", "port"]
      },
      provides: %{
        services: ["NZB"]
      }
    }
  end

  @doc """
  Register the provider
  """
  def register_provider do
    with {:ok, %Provider{} = provider} <- ServiceManager.create_or_update_provider(SabnzbdConnect.registration) do
      Logger.info fn ->
        "Provider Registered as #{provider.lorp_name}"
      end
      provider
    end
  end

end
