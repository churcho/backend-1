defmodule Iotapi.Repo.Migrations.CreateLocation do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :name, :string
      add :location_state, :map
      add :address_one, :string
      add :address_two, :string
      add :city, :string
      add :state, :string
      add :zip, :string
      add :latitude, :string
      add :longitude, :string

      timestamps()
    end

  end
end
