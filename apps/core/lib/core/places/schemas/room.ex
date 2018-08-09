defmodule Core.DB.Room do
  @moduledoc false
  use Core.BaseSchema
  import Ecto.Changeset

  alias Core.DB.Zone

  @derive {Poison.Encoder, except: [:__meta__]}
  schema "rooms" do
    field :name, :string
    field :description, :string

    belongs_to :zone, Zone
    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [
      :name,
      :description,
      :zone_id
    ])
    |> validate_required([])
  end
end
