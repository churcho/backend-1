defmodule Core.EntityManager do
  @moduledoc """
  The boundary for the EntityManager system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias Core.Repo

  alias Core.EntityManager.Entity
  alias Core.EntityManager.EntityType
  alias Core.EntityManager.PropertyType
  alias Core.EntityManager.EventType
  alias Core.EntityManager.ActionType


  @doc """
  Returns the list of entities.

  ## Examples

    iex> list_entities()
    [%Entity{}, ...]

  """
  def list_entities do
    Entity
    |> Repo.all()
    |> Repo.preload([
      :service,
      :entity_type,
      :property_types,
      :entity_properties,
      :action_types,
      :entity_actions,
      :event_types,
      :entity_events
    ])
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
    |> Repo.preload([
      :service,
      :entity_type,
      :property_types,
      :entity_properties,
      :action_types,
      :entity_actions,
      :event_types,
      :entity_events
    ])
  end

  @doc """
  Get an entity property
  """
  def get_entity_property(entity, property_name) do
    entity.property_types
    |> Enum.find(fn v -> v.property.name == property_name end)
  end

  @doc """
  Get entity by uuid

  ## Examples

  """
  def get_entity_by_uuid(uuid) do
    Repo.get_by(Entity, uuid: uuid)
  end

  @doc """
  Get entity type by name

  ## Examples

  """
  def get_entity_type_by_name(name) do
    Repo.get_by(EntityType, name: name)
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
  Creates or updates an EntityType if none exists.

  ## Examples

    iex> create_or_update_entity_type(%{field: value})
    {:ok, %EntityType{}}

    iex> create_or_update_entity_type(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def create_or_update_entity_type(target) do
    result =
      case Repo.get_by(EntityType, name: target.name) do
        nil -> EntityType.changeset(%EntityType{}, target)
        entity_type -> EntityType.changeset(entity_type, target)
      end

    result
    |> Repo.insert_or_update()
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
    |> Repo.insert_or_update()
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

  def update_entity_state(%Entity{} = entity, attrs) do
    old_state =
      if entity.state do
        entity.state
      else
        %{}
      end

    new_state = attrs["state"]
    updated_state = %{state: Map.merge(old_state, new_state)}

    entity
    |> Entity.changeset(updated_state)
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
  Deletes an Entity.

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
  def get_entity_property_state(_entity, property_id) do
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
  def set_entity_property_state(_entity, property_id, value) do
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
end
