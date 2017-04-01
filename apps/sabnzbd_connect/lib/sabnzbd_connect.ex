defmodule SabnzbdConnect do
  import Ecto.Query
  alias Core.Repo
  alias Core.Provider
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
        service_name: "Sabnzbd"
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
     result = 
      case Repo.get_by(Provider, lorp_name: SabnzbdConnect.registration.lorp_name) do
        nil -> Provider.changeset(%Provider{}, SabnzbdConnect.registration)
        provider -> Provider.changeset(provider, SabnzbdConnect.registration)
      end
      |> Repo.insert_or_update
  end

end
