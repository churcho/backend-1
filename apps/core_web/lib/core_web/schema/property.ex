defmodule CoreWeb.Schema.Property do
  @moduledoc """
  Content Type Schemas
  """
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Core.Repo

  @desc "A property"
  object :property do
    field :id, :id
    field :name, :string
    field :type, :string
    field :description, :string
    field :range_value, :range_value, resolve: assoc(:range_value)
    field :bool_value, :bool_value, resolve: assoc(:bool_value)
    field :unit, :unit
  end


  @desc "A range value"
  object :range_value do
    field :min, :integer
    field :max, :integer
  end

  @desc "A boolean value"
  object :bool_value do
    field :id, :id
    field :values, list_of(:boolean)
  end

  @desc "A unit of measurement"
  object :unit do
    field :name, :string
    field :symbol, :string
    field :symbols, list_of(:string)
    field :description, :string
  end

end
