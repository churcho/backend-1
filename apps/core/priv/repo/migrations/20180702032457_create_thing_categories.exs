defmodule Core.Repo.Migrations.CreateThingCategory do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:thing_categories, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :description, :text

      timestamps()
    end
    create unique_index(:thing_categories, [:name])
  end
end
