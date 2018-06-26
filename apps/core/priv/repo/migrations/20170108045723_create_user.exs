defmodule Core.Repo.Migrations.CreateUser do
  @moduledoc false

  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :email, :string
      add :role_uuid, :uuid
      add :last_seen, :utc_datetime
      add :enabled, :boolean, default: false, null: false
      add :hashed_password, :string
      timestamps()
    end
    create unique_index(:users, [:email])
    create index(:users, [:role_uuid])
  end
end
