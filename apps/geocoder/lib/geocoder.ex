defmodule Geocoder do

  alias Core.ServiceManager
  alias Core.ServiceManager.Provider
  @moduledoc """
  Documentation for Geocoder.
  """

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
    with {:ok, %Provider{} = provider} <- ServiceManager.create_or_update_provider(registration()) do
      provider
    end
  end


end
