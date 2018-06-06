defmodule Core.Repo.Migrations.CreateCore.LocationManager.LocationType do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:location_types, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :name, :string
      add :label, :string
      add :description, :text
      timestamps()
    end
    create(unique_index(:location_types, [:name]))
  end
end
