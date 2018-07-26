defmodule Core.Repo.Migrations.CreateConnectionEntities do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:connection_entities, primary_key: false) do
      add :entity_id, references(:connections, on_delete: :nothing, type: :uuid)
      add :connection_id, references(:entities, on_delete: :nothing, type: :uuid)
    end
    create unique_index(:connection_entities, [:entity_id, :connection_id])
  end
end
