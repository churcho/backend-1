defmodule Core.Repo.Migrations.CreateEntities do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:entities, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :name, :string
      add :label, :string
      add :connection_uuid, :uuid
      add :remote_id, :string
      add :components, {:array, :map}

      timestamps()
    end
    create index(:entities, [:connection_uuid])
    create unique_index(:entities, [:remote_id])
  end
end
