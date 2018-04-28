defmodule Core.PropertyManager.RangeProperty do
  @moduledoc """
  Property Schema
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.PropertyManager.RangeProperty
  alias Core.PropertyManager.RangeValue
  alias Core.PropertyManager.Unit

  schema "range_properties" do
    field(:description, :string)
    field(:title, :string)
    field(:name, :string)
    field(:type, :string)
    field(:readOnly, :boolean)
    embeds_one :value, RangeValue, on_replace: :update
    embeds_one :unit, Unit, on_replace: :update

    timestamps()
  end

  @doc false
  def changeset(%RangeProperty{} = property, attrs) do
    property
    |> cast(attrs, [
      :name,
      :description,
      :type,
      :readOnly,
      :title
      ])

    |> cast_embed(:value, with: &range_value_changeset/2)
    |> cast_embed(:unit, with: &unit_changeset/2)
    |> unique_constraint(:name)
    |> validate_required([:name, :description, :type])
  end

  defp range_value_changeset(%RangeValue{} = range_value, attrs) do
    range_value
    |> cast(attrs, [:min, :max])
  end

  defp unit_changeset(%Unit{} = unit, attrs) do
    unit
    |> cast(attrs, [:name, :symbols, :description])
  end
end
