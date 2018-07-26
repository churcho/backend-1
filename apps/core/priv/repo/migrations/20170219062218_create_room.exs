defmodule Core.Repo.Migrations.CreateRoom do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:rooms, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :description, :text
      add :slug, :string

      add :zone_id, references(:zones, on_delete: :nothing, type: :uuid)
      timestamps()
    end
    create index(:rooms, [:zone_id])
    create unique_index(:rooms, [:slug, :name])
  end
end
