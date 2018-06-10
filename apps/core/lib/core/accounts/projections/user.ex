defmodule Core.Accounts.Projections.User do
  @moduledoc false
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}

  schema "users" do
    field :username, :string, unique: true
    field :email, :string, unique: true
    field :last_seen, :utc_datetime
    field :enabled, :boolean
    field :hashed_password, :string
    field :role_uuid, :binary_id

    timestamps()
  end
end
