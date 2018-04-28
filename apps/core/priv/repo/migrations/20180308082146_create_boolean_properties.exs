defmodule Core.Repo.Migrations.CreateBooleanProperties do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:boolean_properties) do
      add(:name, :string)
      add(:title, :string)
      add(:description, :string)
      add(:type, :string)
      add(:readOnly, :boolean)
      add(:value, :map)
      add(:unit, :map)
      timestamps()
    end

    create(unique_index(:boolean_properties, [:name]))
  end
end
