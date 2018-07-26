defmodule Core.Places do
  @moduledoc """
  Boundary for the Places system
  """
  alias Core.Places.{
    Location,
    Zone,
    Room
  }
   alias Core.{
    Repo
  }
  alias Core.Places.Queries.{
    ListLocations,
    ListZones,
    ListRooms
  }

  #locations

  @doc """
  List all locations
  """
  def list_locations do
    ListLocations.new() |> Repo.all()
  end

  @doc """
  Gets a single location.

  Raises `Ecto.NoResultsError` if the Location does not exist.

  ## Examples

      iex> get_location!(123)
      %User{}

      iex> get_location!(456)
      ** (Ecto.NoResultsError)

  """
  def get_location!(id), do: Repo.get!(Location, id)


  @doc """
  Create a new Location.
  """
  def create_location(attrs \\ %{}) do
    %Location{}
    |> Location.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a given location
  """
  def update_location(%Location{} = location, attrs \\ %{}) do
    location
    |> Location.changeset(attrs)
    |> Repo.update()
  end



  @doc """
  Update sunrise and sunset on a location
  """

  def update_sunrise_and_sunset() do
    for location <- list_locations() do
      update_location(location, location)
    end
  end

  @doc """
  Delete a Location. Returns `:ok` on success
  """
  def delete_location(%Location{} = location) do
    Repo.delete(location)
  end

  # Zones

  @doc """
  List all zones
  """
  def list_zones do
    ListZones.new() |> Repo.all()
  end

  @doc """
  Gets a single zone.

  Raises `Ecto.NoResultsError` if the Zone does not exist.

  ## Examples

      iex> get_zone!(123)
      %Zone{}

      iex> get_zone!(456)
      ** (Ecto.NoResultsError)

  """
  def get_zone!(id), do: Repo.get!(Zone, id)

  @doc """
  Create a new Zone.
  """
  def create_zone(attrs \\ %{}) do
    %Zone{}
    |> Zone.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a given location
  """
  def update_zone(%Zone{} = zone, attrs \\ %{}) do
    zone
    |> Zone.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Delete a Zone. Returns `:ok` on success
  """
  def delete_zone(%Zone{} = zone) do
    Repo.delete(zone)
  end

  # Rooms

  @doc """
  List all rooms
  """
  def list_rooms do
    ListRooms.new() |> Repo.all()
  end

  @doc """
  Gets a single room.

  Raises `Ecto.NoResultsError` if the Room does not exist.

  ## Examples

      iex> get_room!(123)
      %Room{}

      iex> get_room!(456)
      ** (Ecto.NoResultsError)

  """
  def get_room!(id), do: Repo.get!(Room, id)

  @doc """
  Create a new room.
  """
  def create_room(attrs \\ %{}) do
    %Room{}
    |> Room.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a given room
  """
  def update_room(%Room{} = room, attrs \\ %{}) do
    room
    |> Room.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Delete a Room. Returns `:ok` on success
  """
  def delete_room(%Room{} = room) do
    Repo.delete(room)
  end
end
