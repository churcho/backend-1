defmodule Geocoder do
  @moduledoc """
  Documentation for Geocoder.
  """

  require Logger
  alias Core.ServiceManager
  alias Core.ServiceManager.Provider


  @doc """
  Basic Registration Information
  """
  def registration do
    %{
      name: "Geocoder (Google)",
      description: "Geocodes!",
      url: "http://www.google.com",
      lorp_name: "Geocoder",
      auth_method: "API_KEY",
      max_services: 1,
      version: "0.0.1",
      configuration: %{
        service_name: "Geocoder"
      },
      provides: %{
        services: ["Geocoding"]
      }
    }
  end

  @doc """
  Register the provider
  """
  def register_provider do
    with {:ok, %Provider{} = provider} <- ServiceManager.create_or_update_provider(Geocoder.registration) do
      Logger.info fn ->
        "Provider Registered as #{provider.lorp_name}"
      end
      provider
    end
  end


end
