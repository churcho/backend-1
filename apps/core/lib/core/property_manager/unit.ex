defmodule Core.PropertyManager.Unit do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.PropertyManager.Property


  schema "units" do
    field :symbol, :string
    field :description, :string
    field :name, :string
    field :symbols, {:array, :string}
    belongs_to :property, Property

    timestamps()
  end

  @doc false
  def changeset(unit, attrs) do
    unit
    |> cast(attrs, [:property_id, :name, :description, :symbol, :symbols])
    |> validate_required([:name, :description])
  end
end
