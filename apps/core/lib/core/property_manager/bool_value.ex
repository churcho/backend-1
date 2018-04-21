defmodule Core.PropertyManager.BoolValue do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.PropertyManager.Property

  schema "bool_values" do
    field :values, {:array, :boolean}
    belongs_to :property, Property

    timestamps()
  end

  @doc false
  def changeset(bool_value, attrs) do
    bool_value
    |> cast(attrs, [:property_id, :values])
    |> validate_required([:property_id, :values])
  end
end
