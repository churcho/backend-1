defmodule Core.Repo.Migrations.CreateThings do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:things, primary_key: false) do
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

      add :thing_category_id, references(:thing_categories, on_delete: :nothing, type: :uuid)
      timestamps()
    end
    create unique_index(:things, [:remote_id])
    create index(:things, [:thing_category_id])
  end
end
