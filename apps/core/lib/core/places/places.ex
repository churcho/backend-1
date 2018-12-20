defmodule Core.Places do
  @moduledoc """
  Boundary for the Places system
  """
  alias Core.DB.{
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

  alias Core.Bus.MiddleWare

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
    {:ok, location} =
    %Location{}
    |> Location.changeset(attrs)
    |> Repo.insert()

    location
    |> broadcast_event(:places_location_created, "SYSTEM")

    {:ok, location}
  end

  @doc """
  Updates a given location
  """
  def update_location(%Location{} = location, attrs \\ %{}) do
    {:ok, location} =
    location
    |> Location.changeset(attrs)
    |> Repo.update()

    location
    |> broadcast_event(:places_location_updated, "SYSTEM")

    {:ok, location}
  end



  @doc """
  Update sunrise and sunset on a location
  """

  def update_sunrise_and_sunset(location_id) do
    location = get_location!(location_id)
    update_location(location, Map.from_struct(location))
  end

  @doc """
  Delete a Location. Returns `:ok` on success
  """
  def delete_location(%Location{} = location) do
    Repo.delete(location)
    location
    |> broadcast_event(:places_location_deleted, "SYSTEM")
  end

  # Zones

  @doc """
  List all zones
  """
  def list_zones do
    ListZones.new()
    |> Repo.all()
    |> Repo.preload([:location])
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
  def get_zone!(id) do
    Repo.get!(Zone, id)
    |> Repo.preload([:location])
  end

  @doc """
  Create a new Zone.
  """
  def create_zone(attrs \\ %{}) do
    {:ok, zone} =
    %Zone{}
    |> Zone.changeset(attrs)
    |> Repo.insert()

    zone
    |> Repo.preload([:location])
    |> broadcast_event(:places_zone_created, "SYSTEM")

    {:ok, zone}
  end

  @doc """
  Updates a given location
  """
  def update_zone(%Zone{} = zone, attrs \\ %{}) do
    {:ok, zone} =
    zone
    |> Zone.changeset(attrs)
    |> Repo.update()

    zone
    |> Repo.preload([:location])
    |> broadcast_event(:places_zone_updated, "SYSTEM")

    {:ok, zone}
  end

  @doc """
  Delete a Zone. Returns `:ok` on success
  """
  def delete_zone(%Zone{} = zone) do
    Repo.delete(zone)
    zone
    |> Repo.preload([:location])
    |> broadcast_event(:places_zone_deleted, "SYSTEM")
  end

  # Rooms

  @doc """
  List all rooms
  """
  def list_rooms do
    ListRooms.new()
    |> Repo.all()
    |> Repo.preload([:zone])
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
  def get_room!(id) do
    Repo.get!(Room, id)
    |> Repo.preload([:zone])
  end


  @doc """
  Create a new room.
  """
  def create_room(attrs \\ %{}) do
    {:ok, room} =
    %Room{}
    |> Room.changeset(attrs)
    |> Repo.insert()

    room
    |> Repo.preload([zone: [:location]])
    |> broadcast_event(:places_room_created, "SYSTEM")

    {:ok, room}
  end

  @doc """
  Updates a given room
  """
  def update_room(%Room{} = room, attrs \\ %{}) do
    {:ok, room} =
    room
    |> Room.changeset(attrs)
    |> Repo.update()

    room
    |> Repo.preload([zone: [:location]])
    |> broadcast_event(:places_room_updated, "SYSTEM")

    {:ok, room}
  end

  @doc """
  Delete a Room. Returns `:ok` on success
  """
  def delete_room(%Room{} = room) do
    Repo.delete(room)

    room
    |> Repo.preload([zone: [:location]])
    |> broadcast_event(:places_room_deleted, "SYSTEM")
  end


  ### Private Stuff


  defp broadcast_event(data, topic, source) do
    event = %{
      topic: topic,
      data: data,
      source: source
    }


    MiddleWare.create(event)
    |> MiddleWare.send()
  end
end
