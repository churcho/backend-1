defmodule Core.Repo.Migrations.AddFieldsToLocations do
  use Ecto.Migration

  def change do
    alter table("locations") do
      add :timezone_id, :string
      add :dst_offset, :integer
      add :raw_time_offset, :integer
      add :sunrise, :integer
      add :sunset, :integer
      add :day_length, :integer
      add :solar_noon, :integer
    end
  end
end
