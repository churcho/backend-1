defmodule Core.PropertyManager do
  @moduledoc """
  The PropertyManager context.
  """

  import Ecto.Query, warn: false
  alias Core.Repo

  alias Core.PropertyManager.BooleanProperty
  alias Core.PropertyManager.RangeProperty

  @doc """
  Returns the list of all properties.

  ## Examples

      iex> list_properties()
      [%BooleanProperty{}, ...]

  """
  def list_properties do
    bools = Repo.all(BooleanProperty)
    ranges = Repo.all(RangeProperty)

    properties =
    bools ++ ranges

    properties
  end

  @doc """
  Returns the list of boolean properties.

  ## Examples

      iex> list_boolean_properties()
      [%BooleanProperty{}, ...]

  """
  def list_boolean_properties do
    Repo.all(BooleanProperty)
  end

  @doc """
  Returns the list of range properties.

  ## Examples

      iex> list_range_properties()
      [%RangeProperty{}, ...]

  """
  def list_range_properties do
    Repo.all(RangeProperty)
  end

  @doc """
  Gets a single BooleanProperty.

  Raises `Ecto.NoResultsError` if the BooleanProperty does not exist.

  ## Examples

      iex> get_boolean_property!(123)
      %BooleanProperty{}

      iex> get_boolean_property!(456)
      ** (Ecto.NoResultsError)

  """
  def get_boolean_property!(id), do: Repo.get!(BooleanProperty, id)

  @doc """
  Gets a single RangeProperty.

  Raises `Ecto.NoResultsError` if the RangeProperty does not exist.

  ## Examples

      iex> get_range_property!(123)
      %BooleanProperty{}

      iex> get_range_property!(456)
      ** (Ecto.NoResultsError)

  """
  def get_range_property!(id), do: Repo.get!(RangeProperty, id)

  @doc """
  Gets a single BooleanProperty by its namne.

  Raises `Ecto.NoResultsError` if the BooleanProperty does not exist.

  ## Examples

  	iex> get_boolean_property_by_name("howdy")
  	%BooleanProperty{}

  	iex> get_boolean_property_by_name(456)
  	** (Ecto.NoResultsError)
  """
  def get_boolean_property_by_name(name) do
    BooleanProperty
    |> Repo.get_by(name: name)
    |> Repo.preload([:unit])
  end

  @doc """
  Gets a single RangeProperty by its namne.

  Raises `Ecto.NoResultsError` if the RangeProperty does not exist.

  ## Examples

  	iex> get_range_property_by_name("howdy")
  	%BooleanProperty{}

  	iex> get_range_property_by_name(456)
  	** (Ecto.NoResultsError)
  """
  def get_range_property_by_name(name) do
    RangeProperty
    |> Repo.get_by(name: name)
    |> Repo.preload([:unit])
  end

  @doc """
  Creates a BooleanProperty.

  ## Examples

      iex> create_boolean_property(%{field: value})
      {:ok, %BooleanProperty{}}

      iex> create_boolean_property(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_boolean_property(attrs \\ %{}) do
    %BooleanProperty{}
    |> BooleanProperty.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a RangeProperty.

  ## Examples

      iex> create_range_property(%{field: value})
      {:ok, %RangeProperty{}}

      iex> create_range_property(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_range_property(attrs \\ %{}) do
    %RangeProperty{}
    |> RangeProperty.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates OR updates a BooleanProperty if none exists.

  ## Examples

    iex> create_or_update_boolean_property(%{field: value})
    {:ok, %Provider{}}

    iex> create_or_update_boolean_property(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def create_or_update_boolean_property(target) do
    result =
      case Repo.get_by(BooleanProperty, name: target.name) do
        nil -> BooleanProperty.changeset(%BooleanProperty{}, target)
        boolean_property -> BooleanProperty.changeset(boolean_property, target)
      end

    result
    |> Repo.insert_or_update()
  end

  @doc """
  Creates OR updates a RangeProperty if none exists.

  ## Examples

    iex> create_or_update_boolean_property(%{field: value})
    {:ok, %Provider{}}

    iex> create_or_update_boolean_property(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def create_or_update_range_property(target) do
    result =
      case Repo.get_by(RangeProperty, name: target.name) do
        nil -> RangeProperty.changeset(%RangeProperty{}, target)
        range_property -> RangeProperty.changeset(range_property, target)
      end

    result
    |> Repo.insert_or_update()
  end

  @doc """
  Updates a BooleanProperty.

  ## Examples

      iex> update_boolean_property(BooleanProperty, %{field: new_value})
      {:ok, %BooleanProperty{}}

      iex> update_boolean_property(BooleanProperty, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_boolean_property(%BooleanProperty{} = boolean_property, attrs) do
    boolean_property
    |> BooleanProperty.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates a RangeProperty.

  ## Examples

      iex> updaterange_property(RangeProperty, %{field: new_value})
      {:ok, %BooleanProperty{}}

      iex> updaterange_property(RangeProperty, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_range_property(%RangeProperty{} = range_property, attrs) do
  range_property
    |> RangeProperty.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a BooleanProperty.

  ## Examples

      iex> delete_boolean_property(BooleanProperty)
      {:ok, %BooleanProperty{}}

      iex> delete_boolean_property(BooleanProperty)
      {:error, %Ecto.Changeset{}}

  """
  def delete_boolean_property(%BooleanProperty{} = boolean_property) do
    Repo.delete(boolean_property)
  end

  @doc """
  Deletes a RangeProperty.

  ## Examples

      iex> delete_range_property(RangeProperty)
      {:ok, %RangeProperty{}}

      iex> delete_range_property(RangeProperty)
      {:error, %Ecto.Changeset{}}

  """
  def delete_range_property(%RangeProperty{} = range_property) do
    Repo.delete(range_property)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking BooleanProperty changes.

  ## Examples

      iex> change_boolean_property(BooleanProperty)
      %Ecto.Changeset{source: %BooleanProperty{}}

  """
  def change_boolean_property(%BooleanProperty{} = boolean_property) do
    BooleanProperty.changeset(boolean_property, %{})
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking RangeProperty changes.

  ## Examples

      iex> change_range_property(RangeProperty)
      %Ecto.Changeset{source: %RangeProperty{}}

  """
  def change_range_property(%RangeProperty{} = range_property) do
    RangeProperty.changeset(range_property, %{})
  end
end
