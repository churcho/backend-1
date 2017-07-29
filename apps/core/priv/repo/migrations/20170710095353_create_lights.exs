defmodule Core.Repo.Migrations.CreateLights do
  use Ecto.Migration

  def change do
    create table(:lights) do
      add :entity_id, references(:service_manager_entities, on_delete: :nothing)
      add :room_id, references(:location_manager_rooms, on_delete: :nothing)

      timestamps()
    end

    create index(:lights, [:entity_id])
    create index(:lights, [:room_id])
  end
end
