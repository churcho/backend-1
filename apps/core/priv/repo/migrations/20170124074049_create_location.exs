defmodule Core.Repo.Migrations.CreateLocation do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :name, :string
      add :state, :map
      add :address_one, :string
      add :address_two, :string
      add :address_city, :string
      add :address_state, :string
      add :address_zip, :string
      add :latitude, :float
      add :longitude, :float
      add :slug, :string
      timestamps()
    end
     create unique_index(:locations, [:slug])
  end
end
