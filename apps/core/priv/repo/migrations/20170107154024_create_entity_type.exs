defmodule Core.Repo.Migrations.CreateEntityType do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:entity_types) do
      add(:name, :string)
      add(:label, :string)
      add(:description, :string)
      timestamps()
    end
    create(unique_index(:entity_types, [:name]))
  end
end
