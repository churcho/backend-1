defmodule CoreWeb.Schema.Entity do
  @moduledoc """
  Entity Schemas
  """
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Core.Repo
  alias CoreWeb.Resolvers.Entities

  @desc "An Entity"
  object :entity do
    field :id, :id
    field :name, :string
    field :display_name, :string
    field :description, :string
    field :uuid, :string
    field :property_types , list_of(:property_type)
  end

  object :property_type do
    field :id, :id
    field :label, :string
    field :name, :string
    field :enabled, :boolean
    field :property, :property do
      resolve assoc(:property)
    end
  end

  object :entity_queries do
    @desc "List all entities"
    field :entities, list_of(:entity) do
      resolve &Entities.list/3
    end
  end
end