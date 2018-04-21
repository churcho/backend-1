defmodule Core.Repo.Migrations.CreateProperties do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:properties) do
      add(:name, :string)
      add(:title, :string)
      add(:description, :string)
      add(:type, :string)
      add(:readOnly, :boolean)
      timestamps()
    end

    create(unique_index(:properties, [:name]))
  end
end
