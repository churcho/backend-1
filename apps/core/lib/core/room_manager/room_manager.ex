defmodule Core.RoomManager do
  @moduledoc """
  The boundary for the LocationManager system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias Core.Repo

  alias Core.RoomManager.Room

  @doc """
  Returns the list of rooms.

  ## Examples

    iex> list_rooms()
    [%Room{}, ...]

  """
  def list_rooms do
    Room
    |> Repo.all()
    |> Repo.preload([:zone, :zone_location, :light_entities])
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
  	|> Repo.preload([:zone, :zone_location, :lights, :light_entities])
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
    |> Room.changeset(attrs)
    |> Repo.insert()
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
    |> Room.changeset(attrs)
    |> Repo.update()
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
  Returns an `%Ecto.Changeset{}` for tracking Room changes.

    ## Examples

    iex> change_room(Room)
    %Ecto.Changeset{source: %Room}}

  """
  def change_room(%Room{} = room) do
    Room.changeset(room, %{})
  end
end
