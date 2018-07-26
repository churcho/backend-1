defmodule Core.Repo.Migrations.CreateEntityCategories do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:entity_categories, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :description, :text

      timestamps()
    end
    create unique_index(:entity_categories, [:name])
  end
end
