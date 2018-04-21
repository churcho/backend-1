defmodule CoreWeb.Resolvers.Properties do
  @moduledoc """
  Resolver for Properties
  """

  def list_properties(_parent, _args, _resolution) do
    {:ok, Core.PropertyManager.list_properties()}
  end

  def list_entities(_parent, _args, _resolution) do
    {:ok, Core.EntityManager.list_entities()}
  end

  def filter_properties(_parent, args, _resolution) do
    {:ok, Core.PropertyManager.filter_properties(args)}
  end


  def get_property(_parent, %{id: id}, _resolution) do
    case Core.PropertyManager.get_property!(id) do
      nil ->
        {:error, "Property ID #{id} not found"}
      property ->
        {:ok, property}
    end
  end
end
