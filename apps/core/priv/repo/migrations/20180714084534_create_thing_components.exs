defmodule Core.Repo.Migrations.CreateThingComponents do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:thing_components, primary_key: false) do
      add :thing_id, references(:things, on_delete: :nothing, type: :uuid)
      add :component_id, references(:components, on_delete: :nothing, type: :uuid)
    end
    create unique_index(:thing_components, [:thing_id, :component_id])
  end
end
