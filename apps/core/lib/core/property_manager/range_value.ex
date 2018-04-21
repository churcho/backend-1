defmodule Core.PropertyManager.RangeValue do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.PropertyManager.Property

  schema "range_values" do
    field :max, :integer
    field :min, :integer
    belongs_to :property, Property
    timestamps()
  end

  @doc false
  def changeset(ranage_value, attrs) do
    ranage_value
    |> cast(attrs, [:property_id, :min, :max])
    |> validate_required([:min, :max])
  end
end
