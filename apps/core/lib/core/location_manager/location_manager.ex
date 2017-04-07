defmodule Core.LocationManager do
  @moduledoc """
  The boundary for the LocationManager system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias Core.Repo

  alias Core.LocationManager.Location
  alias Core.LocationManager.LocationType
  alias Core.LocationManager.Zone
  alias Core.LocationManager.Room



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
  Returns the list of zones.

  ## Examples

    iex> list_zones()
    [%Zone{}, ...]

  """
  def list_zones do
    Zone
  	|> Repo.all()
  	|> Repo.preload([:location, :rooms])
  end

  @doc """
  Returns the list of rooms.

  ## Examples

    iex> list_rooms()
    [%Room{}, ...]

  """
  def list_rooms do
     Repo.all(Room)
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
  def get_location_type!(id), do: Repo.get!(LocationType, id)

  @doc """
  Gets a single Zone.

  Raises `Ecto.NoResultsError` if the Zone does not exist.

  ## Examples

    iex> get_zone!(123)
    %Zone{}

    iex> get_zone!(456)
    ** (Ecto.NoResultsError)

 	"""
  def get_zone!(id) do
    Zone
    |> Repo.get!(id)
  	|> Repo.preload([:location, :rooms])
  end

  	@doc """
  	Gets a single Room.

  	Raises `Ecto.NoResultsError` if the Room does not exist.

  	## Examples

      iex> get_room!(123)
      %Room{}

      iex> get_room!(456)
      ** (Ecto.NoResultsError)

 	"""
  def get_room!(id) do
    Room
    |> Repo.get!(id)
  	|> Repo.preload([:zone])
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
    |> location_changeset(attrs)
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
    |> location_type_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a Zone.

  ## Examples

    iex> create_zone(%{field: value})
    {:ok, %Zone{}}

    iex> create_zone(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def create_zone(attrs \\ %{}) do
    %Zone{}
    |> location_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a Room.

  ## Examples

    iex> create_room(%{field: value})
    {:ok, %Room{}}

    iex> create_room(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def create_room(attrs \\ %{}) do
    %Room{}
    |> location_changeset(attrs)
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
    |> location_changeset(attrs)
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
    |> location_type_changeset(attrs)
    |> Repo.update()
  end


  @doc """
  Updates a Zone.

  ## Examples

    iex> update_zone(Zone, %{field: new_value})
    {:ok, %Zone{}}

    iex> update_zone(Zone, %{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def update_zone(%Zone{} = zone, attrs) do
    zone
    |> zone_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates a Room.

  ## Examples

    iex> update_room(Room, %{field: new_value})
    {:ok, %Room{}}

    iex> update_room(Room, %{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def update_room(%Room{} = room, attrs) do
    room
    |> room_changeset(attrs)
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
  Deletes a Zone.

  ## Examples

    iex> delete_zone(Zone)
    {:ok, %Zone{}}

    iex> delete_zone(Zone)
    {:error, %Ecto.Changeset{}}

  """
  def delete_zone(%Zone{} = zone) do
    Repo.delete(zone)
  end

  @doc """
  Deletes a Room.

  ## Examples

    iex> delete_room(Room)
    {:ok, %Room{}}

    iex> delete_room(Room)
    {:error, %Ecto.Changeset{}}

  """
  def delete_room(%Room{} = room) do
    Repo.delete(room)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking Location changes.

    ## Examples

      iex> change_location(Location)
      %Ecto.Changeset{source: %Location{}}

  """
 	def change_location(%Location{} = location) do
    location_changeset(location, %{})
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking location_type changes.

    ## Examples

      iex> change_location_type(location_type)
      %Ecto.Changeset{source: %LocationType{}}

  """
  def change_location_type(%LocationType{} = location_type) do
    location_type_changeset(location_type, %{})
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking Zone changes.

    ## Examples

      iex> change_zone(Zone)
      %Ecto.Changeset{source: %Zone{}}

  """
  def change_zone(%Zone{} = zone) do
    zone_changeset(zone, %{})
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking Room changes.

    ## Examples

    iex> change_room(Room)
    %Ecto.Changeset{source: %Room}}

  """
  def change_room(%Room{} = room) do
    room_changeset(room, %{})
  end



  defp update_zip(changeset) do
    service = Core.ServiceManager.get_service_by_name("Geocoder")
    location = %{
       address_one: get_change(changeset, :address_one),
       address_city: get_change(changeset, :address_city),
       address_state: get_change(changeset, :address_state),
       address_zip: get_change(changeset, :address_zip)
    }
    if service != nil do
    address = Core.Geocoder.compose_address(location)

    if address != nil do
      coords = Core.Geocoder.get_coords(address, service.api_key)
      changeset
      |> put_change(:latitude, coords.lat)
      |> put_change(:longitude, coords.lng)
      else
        changeset
      end
    else
      changeset
    end
  end

  defp location_changeset(%Location{} = location, attrs) do
    location
    |> cast(attrs, [:name, :state, :address_state, :address_one, :address_two, :address_city, :address_zip, :latitude, :longitude])
    |> validate_required([:name])
    |> update_zip
  end

  defp zone_changeset(%Zone{} = zone, attrs) do
    zone
    |> cast(attrs, [:name, :description, :state, :location_id])
    |> validate_required([:name, :description, :location_id])
  end

  defp room_changeset(%Room{} = room, attrs) do
    room
    |> cast(attrs, [:name, :description, :zone_id])
    |> validate_required([:name, :description, :zone_id])
  end

  defp location_type_changeset(%LocationType{} = location_type, attrs) do
    location_type
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end

end