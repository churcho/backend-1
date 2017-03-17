defmodule Core.Repo.Migrations.CreateSetting do
  use Ecto.Migration

  def change do
    create table(:settings) do
      add :name, :string
      add :value, :map
      add :environment, :string, default: "production"
      add :description, :string, default: "description.."
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end
    create index(:settings, [:user_id])

  end
end
