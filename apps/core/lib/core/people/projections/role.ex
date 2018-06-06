defmodule Core.People.Projections.Role do
  @moduledoc false
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}

  schema "roles" do
    field :name, :string
    field :description, :string
    field :label, :string
    field :users, {:array, :binary_id}, default: []

    timestamps()
  end
end
