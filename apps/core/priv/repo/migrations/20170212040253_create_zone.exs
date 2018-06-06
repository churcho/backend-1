defmodule Core.Repo.Migrations.CreateZone do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:zones, primary_key: false) do
      add :name, :string
      add :description, :string
      add :location_uuid, :uuid
      add :slug, :string
      add :rooms, {:array, :binary_id}
      timestamps()
    end
    create index(:zones, [:location_uuid])
    create unique_index(:zones, [:slug])
  end
end
