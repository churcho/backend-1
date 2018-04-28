defmodule Core.EntityManager.PropertyType do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.EntityManager.PropertyType
  alias Core.PropertyManager.BooleanProperty
  alias Core.EntityManager.Entity

  schema "property_types" do
    field(:state, :map)
    field(:label, :string)
    field(:name, :string)
    field(:enabled, :boolean)
    belongs_to(:boolean_property, BooleanProperty)
    belongs_to(:entity, Entity)

    timestamps()
  end

  @doc false
  def changeset(%PropertyType{} = property_type, attrs) do
    property_type
    |> cast(attrs, [:entity_id, :property_id, :label, :name, :enabled, :state])
    |> validate_required([])
  end
end
