defmodule Core.LocationManager.PropertyType do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.LocationManager.PropertyType
  alias Core.PropertyManager.Property
  alias Core.LocationManager.Location

  schema "property_types" do
    field(:state, :map)
    field(:label, :string)
    field(:name, :string)
    field(:enabled, :boolean)
    belongs_to(:property, Property)
    belongs_to(:location, Location)

    timestamps()
  end

  @doc false
  def changeset(%PropertyType{} = property_type, attrs) do
    property_type
    |> cast(attrs, [:location_id, :property_id, :label, :name, :enabled, :state])
    |> validate_required([])
  end
end
