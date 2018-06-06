defmodule Core.Repo.Migrations.CreateRoom do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:rooms, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :name, :string
      add :description, :text
      add :zone_uuid, :uuid
      add :slug, :string

      timestamps()
    end
    create index(:rooms, [:zone_uuid])
    create unique_index(:rooms, [:slug, :name])
  end
end
