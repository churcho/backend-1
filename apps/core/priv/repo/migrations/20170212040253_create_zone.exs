defmodule Core.Repo.Migrations.CreateZone do
  use Ecto.Migration

  def change do
    create table(:zones) do
      add :name, :string
      add :description, :string
      add :state, :map
      add :location_id, references(:locations, on_delete: :nothing)
      add :slug, :string
      timestamps()
    end
    create index(:zones, [:location_id])
    create unique_index(:locations, [:slug])
  end
end
