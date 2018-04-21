defmodule Core.Repo.Migrations.CreateActionTypes do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:action_types) do
      add(:name, :string)
      add(:description, :string)
      add(:input, :map)
      add(:entity_id, references(:entities, on_delete: :nothing))
      add(:service_id, references(:services, on_delete: :nothing))
      add(:provider_id, references(:providers, on_delete: :nothing))
      add(:location_id, references(:locations, on_delete: :nothing))
      add(:zone_id, references(:zones, on_delete: :nothing))
      add(:room_id, references(:rooms, on_delete: :nothing))
      add(:action_id, references(:actions, on_delete: :nothing))

      timestamps()
    end

    create(index(:action_types, [:provider_id]))
    create(index(:action_types, [:service_id]))
    create(index(:action_types, [:entity_id]))
    create(index(:action_types, [:location_id]))
    create(index(:action_types, [:zone_id]))
    create(index(:action_types, [:room_id]))
    create(index(:action_types, [:action_id]))
  end
end
