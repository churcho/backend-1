defmodule CoreWeb.Resolvers.Entities do
  @moduledoc """
  Resolver for Entities
  """
  alias Core.EntityManager

  def list(_parent, _args, _resolution) do
    {:ok, EntityManager.list_entities()}
  end

  def get(_parent, %{id: id}, _resolution) do
    case EntityManager.get_entity!(id) do
      nil ->
        {:error, "Entity ID #{id} not found"}
      entity ->
        {:ok, entity}
    end
  end
end
