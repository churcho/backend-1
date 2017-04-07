defmodule Huebris do
  @moduledoc """
  Huebris.
  """
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
        required_fields: ["host"]
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
    with {:ok, %Provider{} = provider} <- ServiceManager.create_or_update_provider(registration()) do
      provider
    end
  end

  @doc """
  Connect to a bridge
  """
  def connect(host, api_key) do
    Huex.connect(host, api_key)
  end

  @doc """
  Get the lights payload
  """
  def getlights(bridge)  do
    Huex.lights(bridge)
  end

end
