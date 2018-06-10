defmodule Core.Places do
  @moduledoc """
  Boundary for the Places system
  """
  alias Core.Places.Projections.{
    Location,
    Zone,
    Room
  }
   alias Core.{
    Repo,
    Router
  }
  alias Core.Places.Commands.{
    CreateLocation,
    CreateZone,
    CreateRoom,
    DeleteLocation,
    DeleteZone,
    DeleteRoom,
    UpdateLocation,
    UpdateZone,
    UpdateRoom

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
  Get a location by UUID
  """
  def location_by_uuid(uuid) do
    Repo.get(Location, uuid)
  end

  @doc """
  Create a new Location.
  """
  def create_location(attrs \\ %{}) do
    uuid = UUID.uuid4()

    create_location =
      attrs
      |> CreateLocation.new()
      |> CreateLocation.assign_uuid(uuid)

    with :ok <- Router.dispatch(create_location, consistency: :strong) do
      get(Location, uuid)
    else
      reply -> reply
    end
  end

  @doc """
  Updates a given location
  """
  def update_location(%Location{uuid: location_uuid} = location, attrs \\ %{}) do
    update_location =
      attrs
      |> UpdateLocation.new()
      |> UpdateLocation.assign_location(location)

      with :ok <- Router.dispatch(update_location, consistency: :strong) do
        get(Location, location_uuid)
      else
        reply -> reply
      end
  end

  @doc """
  Delete a Location. Returns `:ok` on success
  """
  def delete_location(%Location{} = location) do
    delete_location =
      %DeleteLocation{}
      |> DeleteLocation.assign_location(location)

    Router.dispatch(delete_location, consistency: :strong)
  end

  # Zones

  @doc """
  List all zones
  """
  def list_zones do
    ListZones.new() |> Repo.all()
  end

  @doc """
  Get a zone by UUID
  """
  def zone_by_uuid(uuid) do
    Repo.get(Zone, uuid)
  end

  @doc """
  Create a new Zone.
  """
  def create_zone(attrs \\ %{}) do
    uuid = UUID.uuid4()

    create_zone =
      attrs
      |> CreateZone.new()
      |> CreateZone.assign_uuid(uuid)

    with :ok <- Router.dispatch(create_zone, consistency: :strong) do
      get(Zone, uuid)
    else
      reply -> reply
    end
  end

  @doc """
  Updates a given location
  """
  def update_zone(%Zone{uuid: zone_uuid} = zone, attrs \\ %{}) do
    update_zone =
      attrs
      |> UpdateZone.new()
      |> UpdateZone.assign_zone(zone)

    with :ok <- Router.dispatch(update_zone, consistency: :strong) do
      get(Zone, zone_uuid)
    else
      reply -> reply
    end
  end

  @doc """
  Delete a Zone. Returns `:ok` on success
  """
  def delete_zone(%Zone{} = zone) do
    delete_zone =
      %DeleteZone{}
      |> DeleteZone.assign_zone(zone)

    Router.dispatch(delete_zone, consistency: :strong)
  end

  # Rooms

  @doc """
  List all rooms
  """
  def list_rooms do
    ListRooms.new() |> Repo.all()
  end

  @doc """
  Get a room by UUID
  """
  def room_by_uuid(uuid) do
    Repo.get(Room, uuid)
  end

  @doc """
  Create a new room.
  """
  def create_room(attrs \\ %{}) do
    uuid = UUID.uuid4()

    create_room =
      attrs
      |> CreateRoom.new()
      |> CreateRoom.assign_uuid(uuid)

    with :ok <- Router.dispatch(create_room, consistency: :strong) do
      get(Room, uuid)
    else
      reply -> reply
    end
  end

  @doc """
  Updates a given room
  """
  def update_room(%Room{uuid: room_uuid} = room, attrs \\ %{}) do
    update_room =
      attrs
      |> UpdateRoom.new()
      |> UpdateRoom.assign_room(room)

    with :ok <- Router.dispatch(update_room, consistency: :strong) do
      get(Room, room_uuid)
    else
      reply -> reply
    end
  end

  @doc """
  Delete a Room. Returns `:ok` on success
  """
  def delete_room(%Room{} = room) do
    delete_room =
      %DeleteRoom{}
      |> DeleteRoom.assign_room(room)

    Router.dispatch(delete_room, consistency: :strong)
  end

  defp get(schema, uuid) do
    case Repo.get(schema, uuid) do
      nil -> {:error, :not_found}
      projection -> {:ok, projection}
    end
  end
end
