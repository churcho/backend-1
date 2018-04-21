defmodule Core.Repo.Migrations.CreateRoom do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :name, :string
      add :description, :string
      add :state, :map
      add :zone_id, references(:zones, on_delete: :nothing)
      add :slug, :string

      timestamps()
    end
    create index(:rooms, [:zone_id])
    create unique_index(:rooms, [:slug])
  end
end
