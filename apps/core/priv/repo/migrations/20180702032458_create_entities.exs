defmodule Core.Repo.Migrations.CreateEntities do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:entities, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :label, :string
      add :remote_id, :string
      add :category, :string
      add :manufacturer, :string
      add :model_number, :string
      add :icon, :string
      add :virtual, :boolean, default: false
      add :state, :map
      add :settings, :map
      add :online, :boolean, default: false

      add :entity_category_id, references(:entity_categories, on_delete: :nothing, type: :uuid)
      timestamps()
    end
    create unique_index(:entities, [:remote_id])
  end
end
