defmodule Huebris do
  @moduledoc """
  Huebris.
  """

  require Logger
  alias Core.ServiceManager
  alias Core.ServiceManager.Provider


  @doc """
  Basic Registration Information
  """
  def registration do
    %{
      name: "Hue",
      description: "Hue Lights",
      url: "http://meethue.com",
      lorp_name: "Huebris",
      auth_method: "PUSH_BUTTON",
      max_services: 5,
      version: "0.0.1",
      configuration: %{
        service_name: "Huebris",
        service_atom: "huebris",
        required_fields: ["host"],
        requires_authorization: true
      },
      provides: %{
        services: ["light"]
      }
    }
  end

  @doc """
  Register the provider
  """
  def register_provider do
    with {:ok, %Provider{} = provider} <- ServiceManager.create_or_update_provider(Huebris.registration) do
      Logger.info fn ->
        "Provider Registered as #{provider.lorp_name}"
      end
      provider
    end
  end
end
