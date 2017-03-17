defmodule Core.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :username, :string
      add :email, :string
      add :encrypted_password, :string
      add :slug, :string

      timestamps()
    end
     create unique_index(:users, [:slug])
  end
end
