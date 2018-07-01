defmodule Core.Services do
  @moduledoc """
  Boundary for the services system
  """

  alias Core.{
    Repo,
    Router
  }

  alias Core.Services.Projections.{
    Provider
  }

  alias Core.Services.Commands.{
    RegisterProvider,
    UpdateProvider
  }

  alias Core.Services.Queries.{
    ListProviders,
    ProviderByServiceName
  }

  # Providers

  @doc """
  List All Providers
  """
  def list_providers do
    ListProviders.new() |> Repo.all
  end

  @doc """
  Get a Provider by UUID
  """
  def provider_by_uuid(uuid) do
    Repo.get(Provider, uuid)
  end

  @doc """
  Get a provider by Service Name
  """
  def provider_by_service_name(service_name) when is_binary(service_name) do
    service_name
    |> ProviderByServiceName.new()
    |> Repo.one()
  end

  @doc """
  Register a Provider
  """
  def register_provider(attrs \\ %{}) do
    uuid = UUID.uuid4()

    register_provider =
      attrs
      |> RegisterProvider.new()
      |> RegisterProvider.assign_uuid(uuid)

    with :ok <- Router.dispatch(register_provider, consistency: :strong) do
      get(Provider, uuid)
    else
      reply -> reply
    end
  end

  @doc """
  Updates a given Provider
  """
  def update_provider(%Provider{uuid: provider_uuid} = provider, attrs \\ %{}) do
    update_provider =
      attrs
      |> UpdateProvider.new()
      |> UpdateProvider.assign_provider(provider)


      with :ok <- Router.dispatch(update_provider, consistency: :strong) do
        get(Provider, provider_uuid)
      else
        reply -> reply
      end
  end

  # private functions

  defp get(schema, uuid) do
    case Repo.get(schema, uuid) do
      nil -> {:error, :not_found}
      projection -> {:ok, projection}
    end
  end
end
