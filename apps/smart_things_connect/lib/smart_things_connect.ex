defmodule SmartThingsConnect do
  @moduledoc """
  Documentation for SmartThings Connector.
  """

  require Logger
  alias Core.ProviderManager
  alias Core.ProviderManager.Provider

  @doc """
  Basic Registration Information
  """
  def registration do
    %{
      name: "SmartThings",
      description: "Home Automation Hub",
      url: "http://smartthings.com",
      lorp_name: "SmartThingsConnect",
      auth_method: "API_KEY",
      max_services: 1,
      version: "0.0.1",
      configuration: %{
        service_name: "",
        required_fields: ["host"]
      },
      metadata: %{},
      provides: [
        %{service: "smartthings"}
      ]
    }
  end

  @doc """
  Register the provider
  """
  def register_provider do
    with {:ok, %Provider{} = provider} <-
           ProviderManager.create_or_update_provider(SmartThingsConnect.registration()) do
      Logger.info(fn ->
        "Provider Registered as #{provider.lorp_name}"
      end)

      provider
    end
  end
end
