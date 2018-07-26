defmodule Core.Places.Room do
  @moduledoc false
  use Core.BaseSchema
  import Ecto.Changeset

  schema "rooms" do
    field :name, :string
    field :description, :string

    belongs_to :zone, Core.Places.Zone
    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [

    ])
    |> validate_required([])
  end
end
