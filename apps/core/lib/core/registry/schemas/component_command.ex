defmodule Core.DB.ComponentCommand do
  @moduledoc false
  use Core.BaseSchema
  import Ecto.Changeset

  alias Core.DB.{
    Component,
    Command
  }

  schema "component_commands" do
    belongs_to :component, Component
    belongs_to :command, Command


    timestamps()
  end

  @doc false
  def changeset(component_ability, attrs) do
    component_ability
    |> cast(attrs, [
      :component_id,
      :command_id
    ])
    |> validate_required([

    ])
  end
end
