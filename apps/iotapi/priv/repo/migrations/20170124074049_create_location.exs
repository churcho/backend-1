defmodule Iotapi.Repo.Migrations.CreateLocation do
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
      add :latitude, :string
      add :longitude, :string

      timestamps()
    end

  end
end
