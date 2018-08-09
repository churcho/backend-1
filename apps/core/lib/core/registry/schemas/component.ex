defmodule Core.DB.Component do
  @moduledoc false
  use Core.BaseSchema
  import Ecto.Changeset
  alias Core.DB.{
    Command,
    Attribute
  }

  schema "components" do
    field :name, :string
    field :label, :string
    field :state, :map

    many_to_many :commands, Command, join_through: "component_commands"
    many_to_many :attributes, Attribute, join_through: "component_attributes"

    timestamps()
  end

  @doc false
  def changeset(component, attrs) do
    component
    |> cast(attrs, [
      :name,
      :label,
      :state
      ])
    |> validate_required([:name])
  end
end
