defmodule Core.Repo.Migrations.CreateRangeValues do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:range_values) do
      add :min, :integer
      add :max, :integer
      add :property_id, references(:properties, on_delete: :nothing)
      timestamps()
    end
    create(index(:range_values, [:property_id]))
  end
end
