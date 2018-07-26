defmodule Core.Repo.Migrations.CreateZone do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:zones, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :description, :text
      add :slug, :string

      add :location_id, references(:locations, on_delete: :nothing, type: :uuid)
      timestamps()
    end
    create index(:zones, [:location_id])
    create unique_index(:zones, [:slug])
  end
end
