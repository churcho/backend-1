defmodule Core.Repo.Migrations.CreateCore.ActionManager.Action do
  @moduledoc false

  use Ecto.Migration

  def change do
    create table(:action_manager_actions) do
      add :name, :string
      add :target_id, :integer
      add :target_type, :string
      add :previous_state, :map
      add :next_state, :map
      add :payload, :map
      timestamps()
    end

  end
end
