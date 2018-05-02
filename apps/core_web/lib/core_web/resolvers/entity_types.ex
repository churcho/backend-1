defmodule CoreWeb.Resolvers.EntityTypes do
  @moduledoc """
  Resolver for Entity Types
  """

  alias Core.EntityManager

  def list(_parent, _args, _resolution) do
    {:ok, EntityManager.list_entity_types()}
  end

  def get(_parent, %{id: id}, _resolution) do
    case EntityManager.get_entity_type!(id) do
      nil ->
        {:error, "Entity Type ID #{id} not found"}
      entity_type ->
        {:ok, entity_type}
    end
  end

  def create(_, %{input: params}, _) do
    case EntityManager.create_entity_type(params) do
      {:error, _} ->
        {:error, "Could not create entity type"}
      {:ok, _} = success ->
        success
    end
  end

  def update(_, %{id: id, entity_type: params}, _) do
    et = EntityManager.get_entity_type!(id)
    case EntityManager.update_entity_type(et, params) do
      {:error, _} ->
        {:error, "Could not update entity type"}
      {:ok, _} = success ->
        success
    end
  end

  def delete(%{id: id}, _) do
    et = EntityManager.get_entity_type!(id)
    case EntityManager.delete_entity_type(et) do
      {:error, _} ->
        {:error, "Could not delete entity type"}
      {:ok, _} = success ->
        success
    end
  end
end
