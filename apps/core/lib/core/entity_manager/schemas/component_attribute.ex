defmodule Core.DB.ComponentAttribute do
  @moduledoc false
  use Core.BaseSchema
  import Ecto.Changeset

  alias Core.DB.{
    Component,
    Attribute
  }

  schema "component_attributes" do
    belongs_to :component, Component
    belongs_to :attribute, Attribute
  end

  @doc false
  def changeset(component_attribute, attrs) do
    component_attribute
    |> cast(attrs, [
      :component_id,
      :attribute_id
    ])
    |> validate_required([

    ])
  end
end
