defmodule Core.Places.Projections.Room do
  @moduledoc false
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}

  schema "rooms" do
    field :name, :string
    field :description, :string
    timestamps()
  end
end
