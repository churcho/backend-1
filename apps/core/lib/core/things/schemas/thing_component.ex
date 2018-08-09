defmodule Core.DB.ThingComponent do
  @moduledoc false
  use Core.BaseSchema
  import Ecto.Changeset

  alias Core.DB.{
    Thing,
    Component
  }

  schema "thing_components" do
    belongs_to :thing, Thing
    belongs_to :component, Component


    timestamps()
  end

  @doc false
  def changeset(thing_component, attrs) do
    thing_component
    |> cast(attrs, [
      :thing_id,
      :component_id
    ])
    |> validate_required([

    ])
  end
end
