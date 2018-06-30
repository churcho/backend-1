defmodule Core.Places.Projections.Zone do
  @moduledoc false
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}

  schema "zones" do
    field :name, :string
    field :description, :string
    field :location_uuid, :binary_id
    field :rooms, {:array, :binary_id}, default: []

    timestamps()
  end
end
