defmodule Core.Repo.Migrations.CreateZone do
  use Ecto.Migration

  def change do
    create table(:location_manager_zones) do
      add :name, :string
      add :description, :string
      add :state, :map
      add :location_id, references(:location_manager_locations, on_delete: :nothing)
      add :slug, :string
      timestamps()
    end
    create index(:location_manager_zones, [:location_id])
    create unique_index(:location_manager_zones, [:slug])
  end
end
