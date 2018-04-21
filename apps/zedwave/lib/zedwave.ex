defmodule Zedwave do
  @moduledoc """
  Zedwave App implementation.
  """

  # Aliases for Core Service Manager
  # These will provide shortcuts to commonly used modules.
  require Logger
  alias Core.ProviderManager
  alias Core.ProviderManager.Provider
  use HTTPoison.Base

  @doc """
  Registration imformation that your app will provide to the core
  service manager.
  """
  def registration do
    %{
      name: "Zedwave Zwave Controller",
      description: "Zwave Controller",
      url: "www.exampleapp.com",
      lorp_name: "Zedwave",
      auth_method: "",
      max_services: 5,
      enabled: true,
      version: "0.0.1",
      allows_import: true,
      configuration: %{
        service_name: "Zedwave",
        service_atom: "zedwave",
        required_fields: ["host"],
        requires_authorization: false
      }
    }
  end

  @doc """
  Register the provider
  """
  def register_provider do
    with {:ok, %Provider{} = provider} <-
           ProviderManager.create_or_update_provider(Zedwave.registration()) do
      Logger.info(fn ->
        "Provider Registered as #{provider.lorp_name}"
      end)

      provider
    end
  end
end
