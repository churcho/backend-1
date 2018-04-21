defmodule Core.ServiceManager do
  @moduledoc """
  The boundary for the ServiceManager system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias Core.Repo

  alias Core.ServiceManager.Service
  alias Core.ServiceManager.PropertyType
  alias Core.ServiceManager.EventType
  alias Core.ServiceManager.ActionType
  alias Core.EntityManager.Entity

  @doc """
  Returns the list of services.

  ## Examples

    iex> list_services()
    [%Service{}, ...]

  """
  def list_services do
    Service
    |> Repo.all()
    |> Repo.preload([
      :provider,
      :entities,
      :property_types,
      :service_properties,
      :action_types,
      :service_actions,
      :event_types,
      :service_events
      ])
  end

  @doc """
  Returns the list of property_types.

  ## Examples

      iex> list_property_types()
      [%PropertyType{}, ...]

  """
  def list_property_types do
    Repo.all(PropertyType)
  end

  @doc """
  Returns the list of event_types.

  ## Examples

      iex> list_event_types()
      [%EventType{}, ...]

  """
  def list_event_types do
    Repo.all(EventType)
  end

  @doc """
  Returns the list of action_types.

  ## Examples

      iex> list_action_types()
      [%ActionType{}, ...]

  """
  def list_action_types do
    Repo.all(ActionType)
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
    |> Repo.preload([
      :provider,
      :property_types,
      :service_properties,
      :action_types,
      :service_actions,
      :event_types,
      :service_events
      ])
    |> Repo.preload(entities: from(e in Entity, order_by: e.name))
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
    |> Repo.preload([
      :provider,
      :entities,
      :property_types,
      :service_properties,
      :action_types,
      :service_actions,
      :event_types,
      :service_events
      ])
  end

  @doc """
  Get a service property
  """
  def get_service_property(service, property_name) do
    service.property_types
    |> Enum.find(fn v -> v.property.name == property_name end)
  end

   @doc """
  Gets a single event_type.

  Raises `Ecto.NoResultsError` if the Event type does not exist.

  ## Examples

      iex> get_event_type!(123)
      %EventType{}

      iex> get_event_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_event_type!(id), do: Repo.get!(EventType, id)

  @doc """
  Gets a single property_type.

  Raises `Ecto.NoResultsError` if the Property type does not exist.

  ## Examples

      iex> get_property_type!(123)
      %PropertyType{}

      iex> get_property_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_property_type!(id), do: Repo.get!(PropertyType, id)

  @doc """
  Gets a single action_type.

  Raises `Ecto.NoResultsError` if the Action type does not exist.

  ## Examples

      iex> get_action_type!(123)
      %ActionType{}

      iex> get_action_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_action_type!(id), do: Repo.get!(ActionType, id)


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
  end

    @doc """
  Creates a action_type.

  ## Examples

      iex> create_action_type(%{field: value})
      {:ok, %ActionType{}}

      iex> create_action_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_action_type(attrs \\ %{}) do
    %ActionType{}
    |> ActionType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a property_type.

  ## Examples

      iex> create_property_type(%{field: value})
      {:ok, %PropertyType{}}

      iex> create_property_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_property_type(attrs \\ %{}) do
    %PropertyType{}
    |> PropertyType.changeset(attrs)
    |> Repo.insert()
  end


  @doc """
  Creates a event_type.

  ## Examples

      iex> create_event_type(%{field: value})
      {:ok, %EventType{}}

      iex> create_event_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event_type(attrs \\ %{}) do
    %EventType{}
    |> EventType.changeset(attrs)
    |> Repo.insert()
  end


  @doc """
  Creates OR updates a PropertyType if none exists.

  ## Examples

    iex> create_or_update_property_types(%{field: value})
    {:ok, %PropertyType{}}

    iex> create_or_update_property_types(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def create_or_update_property_type(target) do
    result =
      case Repo.get_by(PropertyType, name: target.name) do
        nil -> PropertyType.changeset(%PropertyType{}, target)
        property_type -> PropertyType.changeset(property_type, target)
      end

    result
    |> Repo.insert_or_update()
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
  end

  @doc """
  Updates a property_type.

  ## Examples

      iex> update_property_type(property_type, %{field: new_value})
      {:ok, %PropertyType{}}

      iex> update_property_type(property_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_property_type(%PropertyType{} = property_type, attrs) do
    property_type
    |> PropertyType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates an action_type.

  ## Examples

      iex> update_action_type(action_type, %{field: new_value})
      {:ok, %PropertyType{}}

      iex> update_action_type(action_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_action_type(%ActionType{} = action_type, attrs) do
    action_type
    |> ActionType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates a event_type.

  ## Examples

      iex> update_event_type(event_type, %{field: new_value})
      {:ok, %EventType{}}

      iex> update_event_type(event_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event_type(%EventType{} = event_type, attrs) do
    event_type
    |> EventType.changeset(attrs)
    |> Repo.update()
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
  end

  @doc """
  Deletes a ActionType.

  ## Examples

      iex> delete_action_type(action_type)
      {:ok, %ActionType{}}

      iex> delete_action_type(action_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_action_type(%ActionType{} = action_type) do
    Repo.delete(action_type)
  end

  @doc """
  Deletes a PropertyType.

  ## Examples

      iex> delete_property_type(property_type)
      {:ok, %PropertyType{}}

      iex> delete_property_type(property_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_property_type(%PropertyType{} = property_type) do
    Repo.delete(property_type)
  end

  @doc """
  Deletes a EventType.

  ## Examples

      iex> delete_event_type(event_type)
      {:ok, %EventType{}}

      iex> delete_event_type(event_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_event_type(%EventType{} = event_type) do
    Repo.delete(event_type)
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
  Returns an `%Ecto.Changeset{}` for tracking event_type changes.

  ## Examples

      iex> change_event_type(event_type)
      %Ecto.Changeset{source: %EventType{}}

  """
  def change_event_type(%EventType{} = event_type) do
    EventType.changeset(event_type, %{})
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking property_type changes.

  ## Examples

      iex> change_property_type(property_type)
      %Ecto.Changeset{source: %PropertyType{}}

  """
  def change_property_type(%PropertyType{} = property_type) do
    PropertyType.changeset(property_type, %{})
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking action_type changes.

  ## Examples

      iex> change_action_type(action_type)
      %Ecto.Changeset{source: %ActionType{}}

  """
  def change_action_type(%ActionType{} = action_type) do
    ActionType.changeset(action_type, %{})
  end


  # Command and Control

  @doc """
  Get an entity property state
  """
  def get_service_property_state(_service, property_id) do
    result =
      PropertyType
      |> Repo.get(property_id)

    if result do
      result.state
    else
      %{}
    end
  end


  @doc """
  Set an entitiy property state
  """
  def set_service_property_state(_service, property_id, value) do
    result =
      PropertyType
      |> Repo.get(property_id)

    if result do
      state = %{"value" => value}
      update_property_type(result, %{state: state})
    else
      %{}
    end
  end

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
end
