defmodule SabnzbdConnect do
  @moduledoc """
  SabnzbdConnect
  """

  require Logger
  alias Core.ProviderManager
  alias Core.ProviderManager.Provider


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
      provides: [
        %{service: "nzb_downloaderx"}
      ]
    }
  end

  @doc """
  Register the provider
  """
  def register_provider do
    with {:ok, %Provider{} = provider} <- ProviderManager.create_or_update_provider(SabnzbdConnect.registration) do
      Logger.info fn ->
        "Provider Registered as #{provider.lorp_name}"
      end
      provider
    end
  end

end
