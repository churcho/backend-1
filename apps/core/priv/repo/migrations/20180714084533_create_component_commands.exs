defmodule Core.Repo.Migrations.CreateComponentCommands do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:component_commands, primary_key: false) do
      add :command_id, references(:commands, on_delete: :nothing, type: :uuid)
      add :component_id, references(:components, on_delete: :nothing, type: :uuid)
    end

    create index(:component_commands, [:command_id])
    create index(:component_commands, [:component_id])
  end
end
