defmodule Iotapi.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :message, :string
      add :entity, :string
      add :value, :string
      add :units, :string
      add :date, :utc_datetime
      add :source, :string
      add :type, :string
      add :state_changed, :boolean, default: true, null: false
      add :payload, :map

      timestamps()
    end

  end
end
