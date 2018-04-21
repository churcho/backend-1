defmodule Core.Repo.Migrations.CreateLocation do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:locations) do
      add(:name, :string)
      add(:state, :map)
      add(:address_one, :string)
      add(:address_two, :string)
      add(:address_city, :string)
      add(:address_state, :string)
      add(:address_zip, :string)
      add(:latitude, :float)
      add(:longitude, :float)
      add(:slug, :string)
      add(:description, :string)
      add(:metadata, :map)
      add(:location_type_id, references(:location_types, on_delete: :nothing))
      timestamps()
    end

    create(unique_index(:locations, [:slug]))
    create(index(:locations, [:location_type_id]))
  end
end
