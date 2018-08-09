defmodule Core.Repo.Migrations.CreateCommands do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:commands, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :title, :string
      add :action, :string
      add :action_arguments, :map
      add :action_events, :map
      timestamps()
    end
    create unique_index(:commands, [:title])
    create unique_index(:commands, [:action])
  end
end
