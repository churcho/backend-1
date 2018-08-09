defmodule Core.DB.ThingCategory do
  @moduledoc false
  use Core.BaseSchema
  import Ecto.Changeset

  alias Core.DB.Thing

  schema "thing_categories" do
    field :name, :string
    field :description, :string

    has_many :things, Thing
    timestamps()
  end

  @doc false
  def changeset(thing_category, attrs) do
    thing_category
    |> cast(attrs, [
      :name,
      :description

    ])
    |> validate_required([
      :name
    ])
  end

end
