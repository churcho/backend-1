defmodule CoreWeb.Schema.LocationType do
  @moduledoc """
  Location Schemas
  """

  alias CoreWeb.Resolvers.LocationTypes
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Core.Repo

  @desc "An Location Type"
  object :location_type do
    field :id, :id
    field :name, :string
    field :label, :string
    field :description, :string
  end

  input_object :location_type_params do
    field :name, non_null(:string)
    field :label, non_null(:string)
    field :description, :string
  end

  object :location_type_queries do
    @desc "List all location types"
    field :location_types, list_of(:location_type) do
      resolve &LocationTypes.list/3
    end
  end

  object :location_type_mutations do
    field :create_location_type, :location_type do
      arg :location_type, non_null(:location_type_params)
      resolve &LocationTypes.create/3
    end

    field :update_location_type, :location_type do
      arg :id, non_null(:integer)
      arg :location_type, non_null(:location_type_params)
      resolve &LocationTypes.update/3
    end

    field :delete_location_type, :location_type do
      arg :id, non_null(:integer)
      resolve &LocationTypes.delete/2
    end
  end
end
