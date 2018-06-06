defmodule Core.Repo.Migrations.CreateEntityType do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:entity_types, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add(:name, :string)
      add(:label, :string)
      add(:description, :text)
      timestamps()
    end
    create(unique_index(:entity_types, [:name]))
  end
end
