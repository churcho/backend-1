defmodule Core.Repo.Migrations.CreateUser do
  @moduledoc false

  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :first_name, :string
      add :last_name, :string
      add :username, :string
      add :email, :string
      add :hashed_password, :string
      add :slug, :string
      add :role_uuid, :uuid
      add :last_seen, :utc_datetime
      add :enabled, :boolean, default: false, null: false
      timestamps()
    end
    create unique_index(:users, [:username])
    create unique_index(:users, [:email])
    create unique_index(:users, [:slug])
    create index(:users, [:role_uuid])
  end
end
