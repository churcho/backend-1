defmodule Core.Repo.Migrations.CreateEntity do
  use Ecto.Migration

  def change do
    create table(:entities) do
      add :name, :string
      add :uuid, :string
      add :description, :string
      add :label, :string
      add :metadata, :map
      add :state, :map
      add :slug, :string

      timestamps()
    end
    create unique_index(:entities, [:slug])
  end
end