defmodule Core.ThingManager do
  @moduledoc """
  Context Boundary for Things on the system.
  """
  alias Core.Repo
  alias Core.DB.{
    Thing
  }
  alias Core.ThingManager.Queries.{
    ListThings,
    ThingByRemoteId
  }

  @doc """
  List All Things
  """
  def list_things do
    ListThings.new()
    |> Repo.all
  end

  @doc """
  Gets a single thing.

  Raises `Ecto.NoResultsError` if the Thing does not exist.

  ## Examples

      iex> get_thing!(123)
      %Thing{}

      iex> get_thing!(456)
      ** (Ecto.NoResultsError)

  """
  def get_thing!(id) do
    Repo.get!(Thing, id)
  end

  @doc """
  Thing by remote ID
  """
  def thing_by_remote_id(remote_id) when is_binary(remote_id) do
    remote_id
    |> ThingByRemoteId.new()
    |> Repo.one()
  end

  @doc """
  Create an Thing
  """
  def create_thing(attrs \\ %{}) do
    %Thing{}
    |> Thing.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Create an Thing
  """
  def update_thing(%Thing{} = thing, attrs \\ %{}) do
    thing
    |> Thing.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Delete an Thing. Returns `:ok` on success
  """
  def delete_thing(%Thing{} = thing) do
    Repo.delete(thing)
  end
end
