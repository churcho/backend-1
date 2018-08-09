defmodule Core.Services do
  @moduledoc """
  Boundary for the services system
  """

  alias Core.{
    Repo
  }

  alias Core.DB.{
    Provider,
    Connection
  }

  alias Core.Services.Queries.{
    ListProviders,
    ProviderByServiceName,
    ListConnections,
    ConnectionByProviderId
  }

  ### PROVIDERS

  @doc """
  List All Providers
  """
  def list_providers do
    ListProviders.new()
    |> Repo.all
    |> Repo.preload([:connections])
  end

  @doc """
  Gets a single provider.

  Raises `Ecto.NoResultsError` if the Provider does not exist.

  ## Examples

      iex> get_provider!(123)
      %Provider{}

      iex> get_provider!(456)
      ** (Ecto.NoResultsError)

  """
  def get_provider!(id), do: Repo.get!(Provider, id) |> Repo.preload([:connections])

  @doc """
  Get a provider by Service Name
  """
  def provider_by_service_name(service_name) do
    service_name
    |> ProviderByServiceName.new()
    |> Repo.one()
    |> Repo.preload([:connections])
  end

  @doc """
  Register a Provider
  """
  def register_provider(attrs \\ %{}) do
    %Provider{}
    |> Provider.changeset(attrs)
    |> Repo.insert()
  end


  @doc """
  Updates a given Provider
  """
  def update_provider(%Provider{} = provider, attrs \\ %{}) do
    provider
    |> Provider.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Delete a Location. Returns `:ok` on success
  """
  def delete_provider(%Provider{} = provider) do
    Repo.delete(provider)
  end


  ### CONNECTED SERVICES

  @doc """
  List All Connections
  """
  def list_connections do
    ListConnections.new()
    |> Repo.all
    |> Repo.preload([:provider])
  end

  @doc """
  Gets a single connection.

  Raises `Ecto.NoResultsError` if the Connection does not exist.

  ## Examples

      iex> get_connection!(123)
      %Connection{}

      iex> get_connection!(456)
      ** (Ecto.NoResultsError)

  """
  def get_connection!(id) do
    Repo.get!(Connection, id)
    |> Repo.preload([:provider])
  end


  @doc """
  Get an array of connections by provider uuid
  """
  def connection_by_provider_id(provider_id) do
    provider_id
    |> ConnectionByProviderId.new()
    |> Repo.one()
    |> Repo.preload([:provider])
  end

  @doc """
  Connect a Service
  """
  def create_connection(attrs \\ %{}) do
    %Connection{}
    |> Connection.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Update a connection
  """
  def update_connection(%Connection{} = connection, attrs \\ %{}) do
    connection
    |> Connection.changeset(attrs)
    |> Repo.update()
  end


  @doc """
  Delete a Location. Returns `:ok` on success
  """
  def delete_connection(%Connection{} = connection) do
    Repo.delete(connection)
  end
end
