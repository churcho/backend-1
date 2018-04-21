defmodule Core.Repo.Migrations.CreateCore.LocationManager.LocationType do
  use Ecto.Migration

  def change do
    create table(:location_types) do
      add :name, :string
      add :description, :string

      timestamps()
    end

  end
end
