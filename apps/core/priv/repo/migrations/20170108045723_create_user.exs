defmodule Core.Repo.Migrations.CreateUser do
  @moduledoc false
  
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :username, :string
      add :email, :string
      add :encrypted_password, :string
      add :slug, :string
      add :role_id, references(:roles, on_delete: :nothing)
      add :last_seen, :utc_datetime
      add :enabled, :boolean, default: false, null: false
      timestamps()
    end
     create unique_index(:users, [:slug])
     create index(:users, [:role_id])
  end
end
