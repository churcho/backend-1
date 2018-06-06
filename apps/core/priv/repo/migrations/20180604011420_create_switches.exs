defmodule Core.Repo.Migrations.CreateSwitches do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:switches, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :name, :string
      add :label, :string
      add :value, :boolean, default: false, null: false
      timestamps()
    end
    create unique_index(:switches, [:name])
  end
end
