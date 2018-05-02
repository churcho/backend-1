defmodule CoreWeb.Resolvers.Locations do
  @moduledoc """
  Resolver for Entity Types
  """

  alias Core.LocationManager

  def list(_parent, _args, _resolution) do
    {:ok, LocationManager.list_locations()}
  end

  def get(_parent, %{id: id}, _resolution) do
    case LocationManager.get_location!(id) do
      nil ->
        {:error, "Entity Type ID #{id} not found"}
      location ->
        {:ok, location}
    end
  end

  def create(_, %{input: params}, _) do
    case LocationManager.create_location(params) do
      {:error, _} ->
        {:error, "Could not create entity type"}
      {:ok, _} = success ->
        success
    end
  end

  def update(_, %{id: id, location: params}, _) do
    et = LocationManager.get_location!(id)
    case LocationManager.update_location(et, params) do
      {:error, _} ->
        {:error, "Could not update entity type"}
      {:ok, _} = success ->
        success
    end
  end

  def delete(%{id: id}, _) do
    et = LocationManager.get_location!(id)
    case LocationManager.delete_location(et) do
      {:error, _} ->
        {:error, "Could not delete entity type"}
      {:ok, _} = success ->
        success
    end
  end
end
