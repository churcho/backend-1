defmodule Core.Places.Projections.Room do
  @moduledoc false
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}

  schema "rooms" do
    field :name, :string
    field :description, :string
    field :zone_uuid, :binary_id
    timestamps()
  end
end
