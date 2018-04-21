defmodule Core.Repo.Migrations.CreateEventTypes do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:event_types) do
      add(:name, :string)
      add(:description, :string)
      add(:payload, :map)
      add(:entity_id, references(:entities, on_delete: :nothing))
      add(:service_id, references(:services, on_delete: :nothing))
      add(:provider_id, references(:providers, on_delete: :nothing))
      add(:location_id, references(:locations, on_delete: :nothing))
      add(:zone_id, references(:zones, on_delete: :nothing))
      add(:room_id, references(:rooms, on_delete: :nothing))
      add(:action_id, references(:actions, on_delete: :nothing))
      add(:event_id, references(:events, on_delete: :nothing))
      timestamps()
    end

    create(index(:event_types, [:provider_id]))
    create(index(:event_types, [:service_id]))
    create(index(:event_types, [:entity_id]))
    create(index(:event_types, [:location_id]))
    create(index(:event_types, [:zone_id]))
    create(index(:event_types, [:room_id]))
    create(index(:event_types, [:event_id]))
  end
end
