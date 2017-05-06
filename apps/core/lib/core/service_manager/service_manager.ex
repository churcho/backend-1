defmodule Core.ServiceManager do
  @moduledoc """
  The boundary for the ServiceManager system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias Core.Repo

  alias Core.ServiceManager.Provider
  alias Core.ServiceManager.Service
  alias Core.ServiceManager.Entity
  alias Core.ServiceManager.EntityType


  @doc """
  Returns the list of providers.

  ## Examples

    iex> list_providers()
    [%Provider{}, ...]

  """
  def list_providers do
    Provider
    |> Repo.all()
    |> Repo.preload([:services])
  end


  @doc """
  Returns the list of services.

  ## Examples

    iex> list_services()
    [%Service{}, ...]

  """
  def list_services do
    Service
    |> Repo.all()
    |> Repo.preload([:provider, :entities])
  end

  @doc """
  Returns the list of entities.

  ## Examples

    iex> list_entities()
    [%Entity{}, ...]

  """
  def list_entities do
    query = from(e in Entity, order_by: [asc: e.name])
    query
    |> Repo.all
    |> Repo.preload([:service])
  end

  @doc """
  Returns the list of entity_types.

  ## Examples

    iex> list_entity_types()
    [%EntityType{}, ...]

  """
  def list_entity_types do
    EntityType
    |> Repo.all()
  end

  @doc """
  Gets a single Provider.

  Raises `Ecto.NoResultsError` if the Provider does not exist.

    ## Examples

      iex> get_provider!(123)
      %Provider{}

      iex> get_provider!(456)
      ** (Ecto.NoResultsError)

  """

  def get_provider!(id) do
    Provider
    |> Repo.get!(id)
    |> Repo.preload([:services])
  end

  @doc """
  Gets a single Provider by its LORP name.

  Raises `Ecto.NoResultsError` if the Provider does not exist.

    ## Examples

      iex> get_provider_by_lorp_name("lorp_name")
      %Provider{}

      iex> get_provider_lorp_name(456)
      ** (Ecto.NoResultsError)

  """
  def get_provider_by_lorp_name(lorp_name) do
    Provider
    |> Repo.get_by(lorp_name: lorp_name)
    |> Repo.preload([:services])
  end



  @doc """
  Gets a single Service.

  Raises `Ecto.NoResultsError` if the Service does not exist.

  ## Examples

  	iex> get_service!(123)
  	%Service{}

  	iex> get_service!(456)
  	** (Ecto.NoResultsError)

  	"""
  def get_service!(id) do
    Service
    |> Repo.get!(id)
    |> Repo.preload([:provider])
    |> Repo.preload entities: from(e in Entity, order_by: e.name)
  end

  @doc """
  Gets a single Service by its namne.

  Raises `Ecto.NoResultsError` if the Service does not exist.

  ## Examples

  	iex> get_service_by_name("howdy")
  	%Service{}

  	iex> get_service_by_name(456)
  	** (Ecto.NoResultsError)

  	"""
  def get_service_by_name(name) do
    Service
    |> Repo.get_by(name: name)
    |> Repo.preload([:provider, :entities])
  end

  	@doc """
  	Gets a single Entity.

  	Raises `Ecto.NoResultsError` if the Entity does not exist.

  	## Examples

      iex> get_entity!(123)
      %Entity{}

      iex> get_entity!(456)
      ** (Ecto.NoResultsError)

  	"""
  def get_entity!(id) do
    Entity
    |> Repo.get!(id)
    |> Repo.preload([:service])
  end

  @doc """
  Get entity by uuid

  ## Examples

  """
  def get_entity_by_uuid(uuid) do
  	Repo.get_by(Entity, uuid: uuid)
  end

  @doc """
  Gets a single entity_type.

  Raises `Ecto.NoResultsError` if the Entity type does not exist.

  ## Examples

    iex> get_entity_type!(123)
    %EntityType{}

    iex> get_entity_type!(456)
    ** (Ecto.NoResultsError)

  """
  def get_entity_type!(id), do: Repo.get!(EntityType, id)


  @doc """
  Creates a Provider.

  ## Examples

    iex> create_provider(%{field: value})
    {:ok, %Provider{}}

    iex> create_provider(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def create_provider(attrs \\ %{}) do
    %Provider{}
    |> Provider.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates OR updates a Provider if none exists.

  ## Examples

    iex> create_or_update_provider(%{field: value})
    {:ok, %Provider{}}

    iex> create_or_update_provider(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def create_or_update_provider(target) do
    result =
  	case Repo.get_by(Provider, lorp_name: target.lorp_name) do
      nil -> Provider.changeset(%Provider{}, target)
      provider -> Provider.changeset(provider, target)
  	end
    result
  	|> Repo.insert_or_update
  end

  @doc """
  Creates a Service.

  ## Examples

    iex> create_service(%{field: value})
    {:ok, %Service{}}

    iex> create_service(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def create_service(attrs \\ %{}) do
    %Service{}
    |> Service.changeset(attrs)
    |> Repo.insert()
    |> service_create_action
  end

  @doc """
  Creates a Entity.

  ## Examples

    iex> create_entity(%{field: value})
    {:ok, %Entity{}}

    iex> create_entity(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def create_entity(attrs \\ %{}) do
    %Entity{}
    |> Entity.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates or updates an Entity if none exists.

  ## Examples

    iex> create_or_update_entity(%{field: value})
    {:ok, %Entity{}}

    iex> create_or_update_entity(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def create_or_update_entity(target) do
    result =
  	case Repo.get_by(Entity, uuid: target.uuid) do
  		nil -> Entity.changeset(%Entity{}, target)
  		entity -> Entity.changeset(entity, target)
  	end

    result
  	|> Repo.insert_or_update
  end

  @doc """
  	Creates a entity_type.

  ## Examples

    iex> create_entity_type(%{field: value})
    {:ok, %EntityType{}}

    iex> create_entity_type(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def create_entity_type(attrs \\ %{}) do
  	%EntityType{}
  	|> EntityType.changeset(attrs)
  	|> Repo.insert()
  end



  @doc """
  Updates a Provider.

  ## Examples

    iex> update_provider(Provider, %{field: new_value})
    {:ok, %Provider{}}

    iex> update_provider(Provider, %{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def update_provider(%Provider{} = provider, attrs) do
    provider
    |> Provider.changeset(attrs)
    |> Repo.update()
  end


  @doc """
  Updates a Service.

  ## Examples

    iex> update_service(Service, %{field: new_value})
    {:ok, %Service{}}

    iex> update_service(Service, %{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def update_service(%Service{} = service, attrs) do
    service
    |> Service.changeset(attrs)
    |> Repo.update()
    |> service_update_action()
  end

  @doc """
  Updates a Entity.

  ## Examples

    iex> update_entity(Entity, %{field: new_value})
    {:ok, %Entity{}}

    iex> update_entity(Entity, %{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def update_entity(%Entity{} = entity, attrs) do
    entity
    |> Entity.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates a entity_type.

    ## Examples

        iex> update_entity_type(entity_type, %{field: new_value})
        {:ok, %EntityType{}}

        iex> update_entity_type(entity_type, %{field: bad_value})
        {:error, %Ecto.Changeset{}}

   """
  def update_entity_type(%EntityType{} = entity_type, attrs) do
  	entity_type
  	|> EntityType.changeset(attrs)
  	|> Repo.update()
  end


  @doc """
  Deletes a Provider.

  ## Examples

    iex> delete_provider(Provider)
    {:ok, %Provider{}}

    iex> delete_provider(Provider)
    {:error, %Ecto.Changeset{}}

  """
  def delete_provider(%Provider{} = provider) do
    provider
    |> Repo.delete()
  end

  @doc """
  Deletes a Service.

  ## Examples

    iex> delete_service(Service)
    {:ok, %Service{}}

    iex> delete_service(Service)
    {:error, %Ecto.Changeset{}}

  """
  def delete_service(%Service{} = service) do
    service
    |> Repo.delete()
    |> service_delete_action()
  end

  @doc """
  Deletes a Entity.

  ## Examples

    iex> delete_entity(Entity)
    {:ok, %Entity{}}

    iex> delete_entity(Entity)
    {:error, %Ecto.Changeset{}}

  """
  def delete_entity(%Entity{} = entity) do
    entity
    |> Repo.delete()

  end

    @doc """
    Deletes a EntityType.

    ## Examples

        iex> delete_entity_type(entity_type)
        {:ok, %EntityType{}}

        iex> delete_entity_type(entity_type)
        {:error, %Ecto.Changeset{}}

    """
  def delete_entity_type(%EntityType{} = entity_type) do
    entity_type
    |> Repo.delete()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking Provider changes.

  ## Examples

    iex> change_provider(Provider)
    %Ecto.Changeset{source: %Provider{}}

  """
  def change_provider(%Provider{} = provider) do
    Provider.changeset(provider, %{})
  end


  @doc """
  Returns an `%Ecto.Changeset{}` for tracking Service changes.

  ## Examples

    iex> change_service(Service)
    %Ecto.Changeset{source: %Service{}}

  """
  def change_service(%Service{} = service) do
    Service.changeset(service, %{})
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking Entity changes.

  ## Examples

    iex> change_entity(Entity)
    %Ecto.Changeset{source: %Entity}}

  """
  def change_entity(%Entity{} = entity) do
    Entity.changeset(entity, %{})
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking entity_type changes.

  ## Examples

    iex> change_entity_type(entity_type)
    %Ecto.Changeset{source: %EntityType{}}

  """
  def change_entity_type(%EntityType{} = entity_type) do
  	EntityType.changeset(entity_type, %{})
  end


  # Command and Control

  @doc """
  Init a remote service
  """
  def init_service(service) do
    backend = Module.concat(service.provider.lorp_name, Server)
    backend.build_state()
  end

  @doc """
  Authorize a service
  """
  def authorize_service(service) do
    backend = Module.concat(service.provider.lorp_name, Auth)
    backend.start_link(service)
  end

  @doc """
  Import service entities
  """
  def import_entities(service) do
    backend = Module.concat(service.provider.lorp_name, Importer)
    backend.update(service)
  end

  @doc """
  Remove a service
  """
  def remove_service(service) do
    backend = Module.concat(service.provider.lorp_name, Server)
    backend.clear_state()
  end

  defp service_create_action(service) do

    {:ok, serv} = service
    target = serv |> Repo.preload([:provider])
    backend = Module.concat(target.provider.configuration["service_name"], Server)
    backend.service_installed()
    service
  end

  defp service_delete_action(service) do
    {:ok, serv} = service
    backend = Module.concat(serv.provider.configuration["service_name"], Server)
    backend.service_removed()
    service
  end

  defp service_update_action(service) do
    {:ok, serv} = service
    backend = Module.concat(serv.provider.configuration["service_name"], Server)
    backend.service_updated()
    service
  end
end
