defmodule CoreWeb.Schema do
  @moduledoc """
    Absinthe Schema
  """
  use Absinthe.Schema

  import_types CoreWeb.Schema.Property
  import_types CoreWeb.Schema.Entity

  alias CoreWeb.Resolvers



  query do
    @desc "Get all properites"
    field :properties, list_of(:property) do
      arg :type, :string
      arg :order, :string
      resolve &Resolvers.Properties.list_properties/3
    end

    @desc "Get a property by id"
    field :property, :property do
      arg :id, non_null(:id)
      resolve &Resolvers.Properties.get_property/3
    end

    @desc "Get all entities"
    field :entities, list_of(:entity) do
      resolve &Resolvers.Entities.list_entities/3
    end

  end

end
