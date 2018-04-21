defmodule Core.LocationManager do
  @moduledoc """
  The boundary for the LocationManager system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias Core.Repo

  alias Core.LocationManager.Location
  alias Core.LocationManager.LocationType




  @doc """
  Returns the list of locations.

  ## Examples

    iex> list_locations()
    [%Location{}, ...]

  """
  def list_locations do
    Location
    |> Repo.all()
  	|> Repo.preload([:zones])
  end

  @doc """
  Returns the list of location_types.

  ## Examples

      iex> list_location_types()
      [%LocationType{}, ...]

  """
  def list_location_types do
    Repo.all(LocationType)
  end




  @doc """
  Gets a single Location.

  Raises `Ecto.NoResultsError` if the Location does not exist.

    ## Examples

      iex> get_location!(123)
      %Location{}

      iex> get_location!(456)
      ** (Ecto.NoResultsError)

 	"""

  def get_location!(id) do
    Location
    |> Repo.get!(id)
  	|> Repo.preload([:zones])
  end

  @doc """
  Gets a single location_type.

  Raises `Ecto.NoResultsError` if the Location type does not exist.

  ## Examples

      iex> get_location_type!(123)
      %LocationType{}

      iex> get_location_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_location_type!(id) do
    Repo.get!(LocationType, id)
  end





  @doc """
  Creates a Location.

  ## Examples

    iex> create_location(%{field: value})
    {:ok, %Location{}}

    iex> create_location(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def create_location(attrs \\ %{}) do
    %Location{}
    |> Location.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a location_type.

  ## Examples

      iex> create_location_type(%{field: value})
      {:ok, %LocationType{}}

      iex> create_location_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_location_type(attrs \\ %{}) do
    %LocationType{}
    |> LocationType.changeset(attrs)
    |> Repo.insert()
  end





  @doc """
  Updates a Location.

  ## Examples

    iex> update_location(Location, %{field: new_value})
    {:ok, %Location{}}

    iex> update_location(Location, %{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def update_location(%Location{} = location, attrs) do
    location
    |> Location.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates a location_type.

  ## Examples

      iex> update_location_type(location_type, %{field: new_value})
      {:ok, %LocationType{}}

      iex> update_location_type(location_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_location_type(%LocationType{} = location_type, attrs) do
    location_type
    |> LocationType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Location.

  ## Examples

    iex> delete_location(Location)
    {:ok, %Location{}}

    iex> delete_location(Location)
    {:error, %Ecto.Changeset{}}

  """
  def delete_location(%Location{} = location) do
    Repo.delete(location)
  end

  @doc """
  Deletes a LocationType.

  ## Examples

      iex> delete_location_type(location_type)
      {:ok, %LocationType{}}

      iex> delete_location_type(location_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_location_type(%LocationType{} = location_type) do
    Repo.delete(location_type)
  end


  @doc """
  Returns an `%Ecto.Changeset{}` for tracking Location changes.

    ## Examples

      iex> change_location(Location)
      %Ecto.Changeset{source: %Location{}}

  """
 	def change_location(%Location{} = location) do
    Location.changeset(location, %{})
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking location_type changes.

    ## Examples

      iex> change_location_type(location_type)
      %Ecto.Changeset{source: %LocationType{}}

  """
  def change_location_type(%LocationType{} = location_type) do
    LocationType.changeset(location_type, %{})
  end

end
