defmodule Core.EntityManager do
  @moduledoc """
  Context Boundary for Entities on the system.
  """
  alias Core.Repo
  alias Core.DB.{
    Entity,
    Component,
    Attribute,
    Command
  }
  alias Core.EntityManager.Queries.{
    ListEntities,
    EntityByRemoteId,
    CommandByName,
    AttributeByName
  }

  @doc """
  List All Entities
  """
  def list_entities do
    ListEntities.new()
    |> Repo.all
    |> Repo.preload([:components])
  end

  @doc """
  Gets a single entity.

  Raises `Ecto.NoResultsError` if the Entity does not exist.

  ## Examples

      iex> get_entity!(123)
      %Entity{}

      iex> get_entity!(456)
      ** (Ecto.NoResultsError)

  """
  def get_entity!(id) do
    Repo.get!(Entity, id) |> Repo.preload([:components])
  end

  @doc """
  Entitiy by remote ID
  """
  def entity_by_remote_id(remote_id) when is_binary(remote_id) do
    remote_id
    |> EntityByRemoteId.new()
    |> Repo.one()
    |> Repo.preload([:components])
  end

  @doc """
  Create an Entity
  """
  def create_entity(attrs \\ %{}) do
    %Entity{}
    |> Entity.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Create an Entity
  """
  def update_entity(%Entity{} = entity, attrs \\ %{}) do
    entity
    |> Entity.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Delete an Entity. Returns `:ok` on success
  """
  def delete_entity(%Entity{} = entity) do
    Repo.delete(entity)
  end


  ### COMPONENTS

  @doc """
  List All Components
  """
  def list_components do
    Component
    |> Repo.all()
  end

  @doc """
  Gets a single component.

  Raises `Ecto.NoResultsError` if the Component does not exist.

  ## Examples

      iex> get_ component!(123)
      %Entity{}

      iex> get_ component!(456)
      ** (Ecto.NoResultsError)

  """
  def get_component!(id) do
    Repo.get!(Component, id)
  end


  @doc """
  Create a Component
  """
  def create_component(attrs \\ %{}) do
    %Component{}
    |> Component.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Create an Component
  """
  def update_component(%Component{} = component, attrs \\ %{}) do
     component
    |> Component.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Delete an Component. Returns `:ok` on success
  """
  def delete_component(%Component{} = component) do
    Repo.delete( component)
  end

  ### COMMANDS

  @doc """
  List All Commands
  """
  def list_commands do
    Command
    |> Repo.all()
  end

  @doc """
  Gets a single command.

  Raises `Ecto.NoResultsError` if the Command does not exist.

  ## Examples

      iex> get_command!(123)
      %Entity{}

      iex> get_command!(456)
      ** (Ecto.NoResultsError)

  """
  def get_command!(id) do
    Repo.get!(Command, id)
  end

  @doc """
  Get Command by Name
  """
  def get_command_by_name(name) when is_binary(name) do
    name
    |> CommandByName.new()
    |> Repo.one()
  end


  @doc """
  Create a Command
  """
  def create_command(attrs \\ %{}) do
    %Command{}
    |> Command.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Update a Command
  """
  def update_command(%Command{} = command, attrs \\ %{}) do
    command
    |> Command.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Delete an Attribute. Returns `:ok` on success
  """
  def delete_command(%Command{} = command) do
    Repo.delete(command)
  end


  ### ATTRIBUTES

  @doc """
  List All Attributes
  """
  def list_attributes do
    Attribute
    |> Repo.all()
  end

  @doc """
  Gets a single attribute.

  Raises `Ecto.NoResultsError` if the Attribute does not exist.

  ## Examples

      iex> get_attribute!(123)
      %Entity{}

      iex> get_attribute!(456)
      ** (Ecto.NoResultsError)

  """
  def get_attribute!(id) do
    Repo.get!(Attribute, id)
  end

  @doc """
  Get Attribute by Name
  """
  def get_attribute_by_name(name) when is_binary(name) do
    name
    |> AttributeByName.new()
    |> Repo.one()
  end

  @doc """
  Create an Attribute
  """
  def create_attribute(attrs \\ %{}) do
    %Attribute{}
    |> Attribute.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Create an Attribute
  """
  def update_attribute(%Attribute{} = attribute, attrs \\ %{}) do
    attribute
    |> Attribute.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Delete an Attribute. Returns `:ok` on success
  """
  def delete_attribute(%Attribute{} = attribute) do
    Repo.delete(attribute)
  end

end
