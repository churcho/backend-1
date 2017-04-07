defmodule Core.Repo.Migrations.CreateRoom do
  use Ecto.Migration

  def change do
    create table(:location_manager_rooms) do
      add :name, :string
      add :description, :string
      add :state, :map
      add :zone_id, references(:location_manager_zones, on_delete: :nothing)
      add :slug, :string
      
      timestamps()
    end
    create index(:location_manager_rooms, [:zone_id])
    create unique_index(:location_manager_rooms, [:slug])
  end
end
