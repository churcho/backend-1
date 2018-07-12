defmodule Core.Services do
  @moduledoc """
  Boundary for the services system
  """

  alias Core.{
    Repo,
    Router
  }

  alias Core.Services.Projections.{
    Provider,
    Connection,
    Entity
  }

  alias Core.Services.Commands.{
    RegisterProvider,
    UpdateProvider,
    CreateConnection,
    DeleteConnection,
    CreateEntity
  }

  alias Core.Services.Queries.{
    ListProviders,
    ProviderByServiceName,
    ListConnections,
    ConnectionByProviderUuid,
    ListEntities,
    EntityByRemoteId,
    EntityByConnectionUuid
  }

  ### PROVIDERS

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


  ### CONNECTED SERVICES

  @doc """
  List All Connections
  """
  def list_connections do
    ListConnections.new() |> Repo.all
  end

  @doc """
  Get a Connection by UUID
  """
  def connection_by_uuid(uuid) do
    Repo.get(Connection, uuid)
  end

  @doc """
  Get an array of connections by provider uuid
  """
  def connection_by_provider_uuid(provider_uuid) do
    provider_uuid
    |> ConnectionByProviderUuid.new()
    |> Repo.one()
  end

  @doc """
  Connect a Service
  """
  def create_connection(attrs \\ %{}) do
    uuid = UUID.uuid4()

    create_connection =
      attrs
      |> CreateConnection.new()
      |> CreateConnection.assign_uuid(uuid)

    with :ok <- Router.dispatch(create_connection, consistency: :strong) do
      get(Connection, uuid)
    else
      reply -> reply
    end
  end


  @doc """
  Delete a Location. Returns `:ok` on success
  """
  def delete_connection(%Connection{} = connection) do
    delete_connection =
      %DeleteConnection{}
      |> DeleteConnection.assign_connection(connection)

    Router.dispatch(delete_connection, consistency: :strong)
  end

  ### ENTITIES

  @doc """
  List All Entities
  """
  def list_entities do
    ListEntities.new() |> Repo.all
  end

  @doc """
  Entity by UUID
  """
  def entity_by_uuid(uuid) do
    Repo.get(Entity, uuid)
  end

  @doc """
  Entities by connection UUID
  """
  def entities_by_connection_uuid(uuid) do
    uuid
    |> EntityByConnectionUuid.new()
    |> Repo.all()
  end

  @doc """
  Entitiy by remote ID
  """
  def entity_by_remote_id(remote_id) when is_binary(remote_id) do
    remote_id
    |> EntityByRemoteId.new()
    |> Repo.one()
  end

 @doc """
  Connect a Service
  """
  def create_entity(attrs \\ %{}) do
    uuid = UUID.uuid4()

    create_entity =
      attrs
      |> CreateEntity.new()
      |> CreateEntity.assign_uuid(uuid)

    with :ok <- Router.dispatch(create_entity, consistency: :strong) do
      get(Entity, uuid)
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
