defmodule Core.Repo.Migrations.CreateRangeProperties do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:range_properties) do
      add(:name, :string)
      add(:title, :string)
      add(:description, :string)
      add(:type, :string)
      add(:readOnly, :boolean)
      add(:value, :map)
      add(:unit, :map)
      timestamps()
    end

    create(unique_index(:range_properties, [:name]))
  end
end
