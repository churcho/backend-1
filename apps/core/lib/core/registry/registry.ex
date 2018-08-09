defmodule Core.Registry do
  @moduledoc """
  Boundary for Registry Service
  """

  alias Core.Repo
  alias Core.DB.{
    Attribute,
    Command,
    Component
  }
  alias Core.Registry.Queries.{
    AttributeByName,
    CommandByName
  }

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
      %Thing{}

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

  ### Commands

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

  ### Attributes

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
