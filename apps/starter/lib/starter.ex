defmodule Starter do
  @moduledoc """
  Starter App implementation.
  """

  # Aliases for Core Service Manager
  # These will provide shortcuts to commonly used modules.
  require Logger
  alias Core.ProviderManager
  alias Core.ProviderManager.Provider


  @doc """
  Registration imformation that your app will provide to the core
  service manager.
  """
  def registration do
    %{
      name: "Starter Application",
      description: "A friendly description",
      url: "www.exampleapp.com",
      lorp_name: "Starter",
      auth_method: "",
      max_services: 5,
      version: "0.0.1",
      configuration: %{
        service_name: "Starter",
        service_atom: "starter",
        required_fields: ["host"],
        requires_authorization: true
      },
      provides: %{
        services: ["Tutorial"]
      }
    }
  end

  @doc """
  Register the provider
  """
  def register_provider do
    with {:ok, %Provider{} = provider} <- ProviderManager.create_or_update_provider(Starter.registration) do
      Logger.info fn ->
        "Provider Registered as #{provider.lorp_name}"
      end
      provider
    end
  end
end
