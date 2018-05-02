defmodule CoreWeb.Schema.EntityType do
  @moduledoc """
  Entity Schemas
  """

  alias CoreWeb.Resolvers.EntityTypes
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Core.Repo

  @desc "An Entity Type"
  object :entity_type do
    field :id, :id
    field :name, :string
    field :description, :string
  end

  input_object :entity_update_params do
    field :name, non_null(:string)
    field :description, :string
  end

  object :entity_type_queries do
    @desc "List all entity types"
    field :entity_types, list_of(:entity_type) do
      resolve &EntityTypes.list/3
    end
  end

  object :entity_type_mutations do
    field :create_entity_type, :entity_type do
      arg :entity_type, non_null(:entity_update_params)
      resolve &EntityTypes.create/3
    end

    field :update_entity_type, :entity_type do
      arg :id, non_null(:integer)
      arg :entity_type, non_null(:entity_update_params)
      resolve &EntityTypes.update/3
    end

    field :delete_entity_type, :entity_type do
      arg :id, non_null(:integer)
      resolve &EntityTypes.delete/2
    end
  end
end
