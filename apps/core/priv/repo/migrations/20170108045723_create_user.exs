defmodule Core.Repo.Migrations.CreateUser do
  @moduledoc false

  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :email, :string
      add :username, :string
      add :last_seen, :utc_datetime
      add :enabled, :boolean, default: false, null: false
      add :hashed_password, :string

      add :role_id, references(:roles, on_delete: :nothing, type: :uuid)


      timestamps()
    end
    create unique_index(:users, [:email])
    create unique_index(:users, [:username])
    create index(:users, [:role_id])
  end
end
