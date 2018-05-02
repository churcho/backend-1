defmodule CoreWeb.Schema.Location do
  @moduledoc """
  Location Schemas
  """
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Core.Repo
  alias CoreWeb.Resolvers.Locations

  @desc "A Location"
  object :location do
    field :id, :id
    field :name, :string
  end

  input_object :location_params do
    field :name, non_null(:string)
    field :description, :string
  end

  object :location_queries do
    @desc "List all locations"
    field :locations, list_of(:location) do
      resolve &Locations.list/3
    end
  end

  object :location_mutations do
    field :create_location, :location do
      arg :location, non_null(:location_params)
      resolve &Locations.create/3
    end

    field :update_location, :location do
      arg :id, non_null(:integer)
      arg :location, non_null(:location_params)
      resolve &Locations.update/3
    end

    field :delete_location, :location do
      arg :id, non_null(:integer)
      resolve &Locations.delete/2
    end
  end
end
