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
  	result = Repo.all(Provider)

    result
  	|> Repo.preload([:services])
  end


  @doc """
  Returns the list of services.

  ## Examples

    iex> list_services()
    [%Service{}, ...]

  """
  def list_services do
  	result = Repo.all(Service)

    result
  	|> Repo.preload([:provider, :entities])
  end

  @doc """
  Returns the list of entities.

  ## Examples

    iex> list_entities()
    [%Entity{}, ...]

  """
  def list_entities do
  	result = Repo.all(Entity)

    result
  	|> Repo.preload([:service])
  end

  @doc """
  Returns the list of entity_types.

  ## Examples

    iex> list_entity_types()
    [%EntityType{}, ...]

  """
  def list_entity_types do
  	Repo.all(EntityType)
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
  	result = Repo.get!(Provider, id)

    result
  	|> Repo.preload([:services])
  end

  def get_provider_by_lorp_name(lorp_name) do
    result = Repo.get_by(Provider, lorp_name: lorp_name)

    result
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
  	result = Repo.get!(Service, id)

    result
  	|> Repo.preload([:provider, :entities])
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
  	result = Repo.get_by(Service, name: name)

    result
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
  	result = Repo.get!(Entity, id)

    result
  	|> Repo.preload([:service])
  end

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
    	|> provider_changeset(attrs)
    	|> Repo.insert()
  end

  def create_or_update_provider(target) do
    result =
  	case Repo.get_by(Provider, lorp_name: target.lorp_name) do
  		nil -> provider_changeset(%Provider{}, target)
  		provider -> provider_changeset(provider, target)
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
    	|> service_changeset(attrs)
    	|> Repo.insert()
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
    	|> entity_changeset(attrs)
    	|> Repo.insert()
  end


  def create_or_update_entity(target) do
    result =
  	case Repo.get_by(Entity, uuid: target.uuid) do
  		nil -> entity_changeset(%Entity{}, target)
  		entity -> entity_changeset(entity, target)
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
  	|> entity_type_changeset(attrs)
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
    	|> provider_changeset(attrs)
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
    	|> service_changeset(attrs)
    	|> Repo.update()
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
    	|> entity_changeset(attrs)
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
  	|> entity_type_changeset(attrs)
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
  		Repo.delete(provider)
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
  		Repo.delete(service)
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
  		Repo.delete(entity)
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
  	Repo.delete(entity_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking Provider changes.

  ## Examples

    iex> change_provider(Provider)
    %Ecto.Changeset{source: %Provider{}}

  """
  	def change_provider(%Provider{} = provider) do
  	provider_changeset(provider, %{})
  end


  @doc """
  Returns an `%Ecto.Changeset{}` for tracking Service changes.

  ## Examples

    iex> change_service(Service)
    %Ecto.Changeset{source: %Service{}}

  """
  	def change_service(%Service{} = service) do
    	service_changeset(service, %{})
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking Entity changes.

  ## Examples

    iex> change_entity(Entity)
    %Ecto.Changeset{source: %Entity}}

  """
  def change_entity(%Entity{} = entity) do
    entity_changeset(entity, %{})
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking entity_type changes.

  ## Examples

    iex> change_entity_type(entity_type)
    %Ecto.Changeset{source: %EntityType{}}

  """
  def change_entity_type(%EntityType{} = entity_type) do
  	entity_type_changeset(entity_type, %{})
  end


  	defp provider_changeset(%Provider{} = provider, attrs) do
      provider
      |> cast(attrs, [:name,
                       :description,
                       :url,
                       :enabled,
                       :lorp_name,
                       :auth_method,
                       :registered_at,
                       :last_seen,
                       :provides,
                       :max_services,
                       :configuration,
                       :logo_path,
                       :icon_path,
                       :keywords,
                       :slug,
                       :version])
      |> validate_required([:name, :url])
  	end

  def service_changeset(%Service{} = service, attrs) do
  	service
  	|> cast(attrs, [:name,
  	                 :host,
  	                 :port,
  	                 :client_id,
  	                 :client_secret,
  	                 :access_token,
  	                 :api_key,
  	                 :enabled,
  	                 :authorized,
  	                 :searchable,
  	                 :search_path,
  	                 :state,
  	                 :slug,
  	                 :imported_at,
  	                 :allows_import,
  	                 :requires_authorization,
  	                 :metadata,
  	                 :configuration,
  	                 :provider_id])
  	|> validate_required([:name, :provider_id])
  end

  defp entity_changeset(%Entity{} = entity, attrs) do
  	entity
  	|> cast(attrs, [:name,
  	                 :uuid,
  	                 :description,
  	                 :label,
  	                 :metadata,
  	                 :state,
  	                 :display_name,
  	                 :slug,
  	                 :configuration,
  	                 :source,
  	                 :service_id])
  	|> validate_required([:name, :uuid])
  end

  defp entity_type_changeset(%EntityType{} = entity_type, attrs) do
  	entity_type
  	|> cast(attrs, [:name, :description])
  	|> validate_required([:name, :description])
  end

  end
