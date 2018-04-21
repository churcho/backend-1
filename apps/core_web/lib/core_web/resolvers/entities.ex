defmodule CoreWeb.Resolvers.Entities do
  @moduledoc """
  Resolver for Entities
  """

  def list_entities(_parent, _args, _resolution) do
    {:ok, Core.EntityManager.list_entities()}
  end


  def get_entity(_parent, %{id: id}, _resolution) do
    case Core.EntityManager.get_entity!(id) do
      nil ->
        {:error, "Entity ID #{id} not found"}
      entity ->
        {:ok, entity}
    end
  end
end
