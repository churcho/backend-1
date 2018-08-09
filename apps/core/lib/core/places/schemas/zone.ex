defmodule Core.DB.Zone do
  @moduledoc false
  use Core.BaseSchema
  import Ecto.Changeset
  alias Core.DB.Location

  @derive {Poison.Encoder, except: [:__meta__]}

  schema "zones" do
    field :name, :string
    field :description, :string

    belongs_to :location, Location
    timestamps()
  end

  @doc false
  def changeset(zone, attrs) do
    zone
    |> cast(attrs, [
      :name,
      :location_id,
      :description
    ])
    |> validate_required([])
  end
end
