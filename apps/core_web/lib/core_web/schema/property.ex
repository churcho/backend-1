defmodule CoreWeb.Schema.Property do
  @moduledoc """
  Content Type Schemas
  """
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Core.Repo
  alias CoreWeb.Resolvers.Properties

  @desc "A property"
  union :property do
    types [:boolean_property, :range_property]
    resolve_type fn
      %Core.PropertyManager.BooleanProperty{}, _ ->
        :boolean_property
      %Core.PropertyManager.RangeProperty{}, _ ->
        :range_property
    end
  end

  object :boolean_property do
    field :name, :string
    field :type, :string
    field :value, :bool_value
  end

  object :range_property do
    field :name, :string
    field :type, :string
    field :value, :range_value
  end

  object :range_value do
    field :min, :integer
    field :max, :integer
  end

  object :bool_value do
    field :enum_type, list_of(:boolean)
  end

  object :property_queries do
    @desc "List all properites"
    field :properties, list_of(:property) do
      arg :type, :string
      arg :order, :string
      resolve &Properties.list_properties/3
    end
  end
end
