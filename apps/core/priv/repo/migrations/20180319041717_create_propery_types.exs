defmodule Core.Repo.Migrations.CreatePropertyTypes do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:property_types) do
      add(:entity_id, references(:entities, on_delete: :nothing))
      add(:service_id, references(:services, on_delete: :nothing))
      add(:provider_id, references(:providers, on_delete: :nothing))
      add(:location_id, references(:locations, on_delete: :nothing))
      add(:zone_id, references(:zones, on_delete: :nothing))
      add(:room_id, references(:rooms, on_delete: :nothing))
      add(:action_id, references(:actions, on_delete: :nothing))
      add(:property_id, references(:properties, on_delete: :nothing))
      add(:label, :string)
      add(:name, :string)
      add(:enabled, :boolean)
      add(:state, :map)
      timestamps()
    end
    create(unique_index(:property_types, [:name]))
    create(index(:property_types, [:provider_id]))
    create(index(:property_types, [:service_id]))
    create(index(:property_types, [:entity_id]))
    create(index(:property_types, [:location_id]))
    create(index(:property_types, [:zone_id]))
    create(index(:property_types, [:room_id]))
    create(index(:property_types, [:property_id]))
  end
end
