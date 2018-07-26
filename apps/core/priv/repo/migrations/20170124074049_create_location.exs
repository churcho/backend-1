defmodule Core.Repo.Migrations.CreateLocation do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:locations, primary_key: false) do
      add :id, :uuid, primary_key: true
      add(:name, :string)
      add(:address_one, :string)
      add(:address_two, :string)
      add(:address_city, :string)
      add(:address_country, :string)
      add(:address_state, :string)
      add(:address_zip, :string)
      add(:latitude, :float)
      add(:longitude, :float)
      add(:slug, :string)
      add(:description, :string)
      add :timezone_id, :string
      add :dst_offset, :integer
      add :raw_time_offset, :integer
      add :sunrise, :integer
      add :sunset, :integer
      add :day_length, :integer
      add :solar_noon, :integer
      timestamps()
    end

    create(unique_index(:locations, [:slug]))
  end
end
