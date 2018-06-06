defmodule Core.Repo.Migrations.CreateLocation do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:locations, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add(:name, :string)
      add(:address_one, :string)
      add(:address_two, :string)
      add(:address_city, :string)
      add(:address_state, :string)
      add(:address_zip, :string)
      add(:latitude, :float)
      add(:longitude, :float)
      add(:slug, :string)
      add(:description, :string)
      add(:location_type_uuid, :uuid)
      add(:zones, {:array, :binary_id})
      timestamps()
    end

    create(unique_index(:locations, [:slug]))
    create(index(:locations, [:location_type_uuid]))
  end
end
