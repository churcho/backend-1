defmodule CoreWeb.Resolvers.LocationTypes do
  @moduledoc """
  Resolver for Location Types
  """

  alias Core.LocationManager

  def list(_parent, _args, _resolution) do
    {:ok, LocationManager.list_location_types()}
  end

  def get(_parent, %{id: id}, _resolution) do
    case LocationManager.get_location_type!(id) do
      nil ->
        {:error, "Location Type ID #{id} not found"}
      location_type ->
        {:ok, location_type}
    end
  end

  def create(_, %{location_type: params}, _) do
    case LocationManager.create_location_type(params) do
      {:error, _} ->
        {:error, "Could not create location type"}
      {:ok, _} = success ->
        success
    end
  end

  def update(_, %{id: id, location_type: params}, _) do
    et = LocationManager.get_location_type!(id)
    case LocationManager.update_location_type(et, params) do
      {:error, _} ->
        {:error, "Could not update location type"}
      {:ok, _} = success ->
        success
    end
  end

  def delete(%{id: id}, _) do
    et = LocationManager.get_location_type!(id)
    case LocationManager.delete_location_type(et) do
      {:error, _} ->
        {:error, "Could not delete location type"}
      {:ok, _} = success ->
        success
    end
  end
end
