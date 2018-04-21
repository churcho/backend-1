defmodule Core.PropertyManager do
  @moduledoc """
  The PropertyManager context.
  """

  import Ecto.Query, warn: false
  alias Core.Repo

  alias Core.PropertyManager.Property
  alias Core.PropertyManager.RangeValue
  alias Core.PropertyManager.Unit
  alias Core.PropertyManager.BoolValue

  @doc """
  Returns the list of properties.

  ## Examples

      iex> list_properties()
      [%Property{}, ...]

  """
  def list_properties do
    Repo.all(Property)
    |> Repo.preload([:range_value, :bool_value, :unit])
  end

  @doc """
  Returns the list of range_values.

  ## Examples

      iex> list_range_values()
      [%RangeValue{}, ...]

  """
  def list_range_values do
    Repo.all(RangeValue)
  end

  @doc """
  Returns the list of bool_values.

  ## Examples

      iex> list_bool_values()
      [%BoolValue{}, ...]

  """
  def list_bool_values do
    Repo.all(BoolValue)
  end

  @doc """
  Returns the list of units.

  ## Examples

      iex> list_units()
      [%Unit{}, ...]

  """
  def list_units do
    Repo.all(Unit)
  end

  @doc """
  Gets a single property.

  Raises `Ecto.NoResultsError` if the Property does not exist.

  ## Examples

      iex> get_property!(123)
      %Property{}

      iex> get_property!(456)
      ** (Ecto.NoResultsError)

  """
  def get_property!(id), do: Repo.get!(Property, id) |> Repo.preload([:range_value, :bool_value, :unit])

  @doc """
  Gets a single range_value.

  Raises `Ecto.NoResultsError` if the Range value does not exist.

  ## Examples

      iex> get_range_value!(123)
      %RangeValue{}

      iex> get_range_value!(456)
      ** (Ecto.NoResultsError)

  """
  def get_range_value!(id), do: Repo.get!(RangeValue, id)

  @doc """
  Gets a single bool_value.

  Raises `Ecto.NoResultsError` if the Bool value does not exist.

  ## Examples

      iex> get_bool_value!(123)
      %BoolValue{}

      iex> get_bool_value!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bool_value!(id), do: Repo.get!(BoolValue, id)


  @doc """
  Gets a single unit.

  Raises `Ecto.NoResultsError` if the Unit does not exist.

  ## Examples

      iex> get_unit!(123)
      %Unit{}

      iex> get_unit!(456)
      ** (Ecto.NoResultsError)

  """
  def get_unit!(id), do: Repo.get!(Unit, id)

  @doc """
  Gets a single Service by its namne.

  Raises `Ecto.NoResultsError` if the Service does not exist.

  ## Examples

  	iex> get_service_by_name("howdy")
  	%Service{}

  	iex> get_service_by_name(456)
  	** (Ecto.NoResultsError)

  """
  def get_property_by_name(name) do
    Property
    |> Repo.get_by(name: name)
    |> Repo.preload([:range_value])
  end


  def filter_properties(%{type: type, order: order}) do
     new_order = String.to_atom(order) || :desc
     Repo.all(
        from p in Property,
        where: p.type == ^type,
        order_by: [{^new_order, p.name}],
        select: p
      )
      |> Repo.preload([:range_value, :bool_value, :unit])
  end

  def filter_properties(%{order: order}) do
    new_order = String.to_atom(order) || :desc
    Repo.all(
       from p in Property,
       order_by: [{^new_order, p.name}],
       select: p
     )
     |> Repo.preload([:range_value, :bool_value, :unit])
 end

  def filter_properties(%{type: type}) do
    Repo.all(
       from p in Property,
       where: p.type == ^type,
       order_by: [{:desc, p.name}],
       select: p
     )
     |> Repo.preload([:range_value, :bool_value, :unit])
 end

 def filter_properties(%{}) do
  Repo.all(
     from p in Property,
     order_by: [{:desc, p.name}],
     select: p
   )
   |> Repo.preload([:range_value, :bool_value, :unit])
end

  @doc """
  Creates a property.

  ## Examples

      iex> create_property(%{field: value})
      {:ok, %Property{}}

      iex> create_property(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_property(attrs \\ %{}) do
    %Property{}
    |> Property.changeset(attrs)
    |> Repo.insert()
  end

  def preload_property_assoc(property) do
    property
    |> Repo.preload([:unit, :range_value, :bool_value])
  end

  @doc """
  Creates a range_value.

  ## Examples

      iex> create_range_value(%{field: value})
      {:ok, %RangeValue{}}

      iex> create_range_value(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_range_value(attrs \\ %{}) do
    %RangeValue{}
    |> RangeValue.changeset(attrs)
    |> Repo.insert()
  end


  @doc """
  Creates a bool_value.

  ## Examples

      iex> create_bool_value(%{field: value})
      {:ok, %BoolValue{}}

      iex> create_bool_value(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bool_value(attrs \\ %{}) do
    %BoolValue{}
    |> BoolValue.changeset(attrs)
    |> Repo.insert()
  end


  @doc """
  Creates a unit.

  ## Examples

      iex> create_unit(%{field: value})
      {:ok, %Unit{}}

      iex> create_unit(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_unit(attrs \\ %{}) do
    %Unit{}
    |> Unit.changeset(attrs)
    |> Repo.insert()

  end

  @doc """
  Creates OR updates a Property if none exists.

  ## Examples

    iex> create_or_update_property(%{field: value})
    {:ok, %Provider{}}

    iex> create_or_update_property(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def create_or_update_unit(target) do
    result =
      case Repo.get_by(Unit, id: target.id) do
        nil -> Unit.changeset(%Unit{}, target)
        unit -> Unit.changeset(unit, target)
      end

    result
    |> Repo.insert_or_update()
  end

  @doc """
  Creates OR updates a Property if none exists.

  ## Examples

    iex> create_or_update_property(%{field: value})
    {:ok, %Provider{}}

    iex> create_or_update_property(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def create_or_update_property(target) do
    result =
      case Repo.get_by(Property, name: target.name) do
        nil -> Property.changeset(%Property{}, target)
        property -> Property.changeset(property, target)
      end

    result
    |> Repo.insert_or_update()
  end

  @doc """
  Updates a property.

  ## Examples

      iex> update_property(property, %{field: new_value})
      {:ok, %Property{}}

      iex> update_property(property, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_property(%Property{} = property, attrs) do
    property
    |> Property.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates a range_value.

  ## Examples

      iex> update_range_value(range_value, %{field: new_value})
      {:ok, %RangeValue{}}

      iex> update_range_value(range_value, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_range_value(%RangeValue{} = range_value, attrs) do
    range_value
    |> RangeValue.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates a bool_value.

  ## Examples

      iex> update_bool_value(bool_value, %{field: new_value})
      {:ok, %BoolValue{}}

      iex> update_bool_value(bool_value, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bool_value(%BoolValue{} = bool_value, attrs) do
    bool_value
    |> BoolValue.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates a unit.

  ## Examples

      iex> update_unit(unit, %{field: new_value})
      {:ok, %Unit{}}

      iex> update_unit(unit, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_unit(%Unit{} = unit, attrs) do
    unit
    |> Unit.changeset(attrs)
    |> Repo.update()
  end


  @doc """
  Deletes a Property.

  ## Examples

      iex> delete_property(property)
      {:ok, %Property{}}

      iex> delete_property(property)
      {:error, %Ecto.Changeset{}}

  """
  def delete_property(%Property{} = property) do
    Repo.delete(property)
  end

  @doc """
  Deletes a RangeValue.

  ## Examples

      iex> delete_range_value(range_value)
      {:ok, %RangeValue{}}

      iex> delete_range_value(range_value)
      {:error, %Ecto.Changeset{}}

  """
  def delete_range_value(%RangeValue{} = range_value) do
    Repo.delete(range_value)
  end

  @doc """
  Deletes a BoolValue.

  ## Examples

      iex> delete_bool_value(bool_value)
      {:ok, %BoolValue{}}

      iex> delete_bool_value(bool_value)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bool_value(%BoolValue{} = bool_value) do
    Repo.delete(bool_value)
  end



  @doc """
  Deletes a Unit.

  ## Examples

      iex> delete_unit(unit)
      {:ok, %Unit{}}

      iex> delete_unit(unit)
      {:error, %Ecto.Changeset{}}

  """
  def delete_unit(%Unit{} = unit) do
    Repo.delete(unit)
  end


  @doc """
  Returns an `%Ecto.Changeset{}` for tracking property changes.

  ## Examples

      iex> change_property(property)
      %Ecto.Changeset{source: %Property{}}

  """
  def change_property(%Property{} = property) do
    Property.changeset(property, %{})
  end


  @doc """
  Returns an `%Ecto.Changeset{}` for tracking range_value changes.

  ## Examples

      iex> change_range_value(range_value)
      %Ecto.Changeset{source: %RangeValue{}}

  """
  def change_range_value(%RangeValue{} = range_value) do
    RangeValue.changeset(range_value, %{})
  end


  @doc """
  Returns an `%Ecto.Changeset{}` for tracking unit changes.

  ## Examples

      iex> change_unit(unit)
      %Ecto.Changeset{source: %Unit{}}

  """
  def change_unit(%Unit{} = unit) do
    Unit.changeset(unit, %{})
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bool_value changes.

  ## Examples

      iex> change_bool_value(bool_value)
      %Ecto.Changeset{source: %BoolValue{}}

  """
  def change_bool_value(%BoolValue{} = bool_value) do
    BoolValue.changeset(bool_value, %{})
  end
end
