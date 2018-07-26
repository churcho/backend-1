defmodule Core.Places.Zone do
  @moduledoc false
  use Core.BaseSchema
  import Ecto.Changeset

  schema "zones" do
    field :name, :string
    field :description, :string

    belongs_to :location, Core.Places.Location
    timestamps()
  end

  @doc false
  def changeset(zone, attrs) do
    zone
    |> cast(attrs, [

    ])
    |> validate_required([])
  end
end
