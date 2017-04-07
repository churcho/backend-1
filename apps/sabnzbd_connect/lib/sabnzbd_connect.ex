defmodule SabnzbdConnect do
  import Ecto.Query
  alias Core.Repo
  alias Core.ServiceManager
  alias Core.ServiceManager.Provider
  @moduledoc """
  Documentation for Sabnzbd.
  """

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
    with {:ok, %Provider{} = provider} <- ServiceManager.create_or_update_provider(registration) do
      IO.puts "Registered "<>provider.name
    end
  end

end
