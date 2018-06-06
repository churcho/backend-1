defmodule Core.Places do
  @moduledoc """
  Boundary for the Places system
  """
  alias Core.Places.Projections.Location
  alias Core.{
    Repo,
    Router
  }
  alias Core.Places.Commands.{
    CreateLocation,
    DeleteLocation,
    UpdateLocation

  }
  alias Core.Places.Queries.{
    ListLocations
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

  defp get(schema, uuid) do
    case Repo.get(schema, uuid) do
      nil -> {:error, :not_found}
      projection -> {:ok, projection}
    end
  end
end
