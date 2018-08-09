defmodule Core.Repo.Migrations.CreateConnectionThings do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:connection_things, primary_key: false) do
      add :thing_id, references(:things, on_delete: :nothing, type: :uuid)
      add :connection_id, references(:connections, on_delete: :nothing, type: :uuid)
    end
    create unique_index(:connection_things, [:thing_id, :connection_id])
  end
end
