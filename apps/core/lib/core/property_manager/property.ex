defmodule Core.PropertyManager.Property do
  @moduledoc """
  Property Schema
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.PropertyManager.Property
  alias Core.PropertyManager.RangeValue
  alias Core.PropertyManager.BoolValue
  alias Core.PropertyManager.Unit

  schema "properties" do
    field(:description, :string)
    field(:title, :string)
    field(:name, :string)
    field(:type, :string)
    field(:readOnly, :boolean)

    has_one :range_value, RangeValue
    has_one :bool_value, BoolValue
    has_one :unit, Unit

    timestamps()
  end

  @doc false
  def changeset(%Property{} = property, attrs) do
    property
    |> cast(attrs, [:name, :description, :type, :readOnly, :title])
    |> unique_constraint(:name)
    |> validate_required([:name, :description, :type])
  end
end
