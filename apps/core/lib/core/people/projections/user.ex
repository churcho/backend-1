defmodule Core.People.Projections.User do
  @moduledoc false
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :username, :string
    field :email, :string
    field :slug, :string
    field :last_seen, :utc_datetime
    field :enabled, :boolean
    field :hashed_password, :string
    field :role_uuid, :binary_id

    timestamps()
  end
end
