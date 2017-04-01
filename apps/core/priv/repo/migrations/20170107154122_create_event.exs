defmodule Core.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :message, :string
      add :uuid, :string
      add :value, :string
      add :units, :string
      add :source, :string
      add :source_event, :string
      add :type, :string
      add :state_changed, :boolean, default: true, null: false
      add :payload, :map
      add :metadata, :map
      add :permissions, :map
      add :service_id, references(:services, on_delete: :nothing)
      add :entity_id, references(:entities, on_delete: :nothing)
      add :date, :utc_datetime
      add :expiration, :utc_datetime
      timestamps()
    end
    create index(:events, [:service_id])
    create index(:events, [:entity_id])
  end
end
