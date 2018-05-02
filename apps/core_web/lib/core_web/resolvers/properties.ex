defmodule CoreWeb.Resolvers.Properties do
  @moduledoc """
  Resolver for Properties
  """

  alias Core.PropertyManager

  def list_properties(_parent, _args, _resolution) do
    {:ok, PropertyManager.list_properties()}
  end
end
