defmodule Core.Repo.Migrations.CreateLevels do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:levels, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :name, :string
      add :label, :string
      add :value, :integer

      timestamps()
    end
    create unique_index(:levels, [:name])
  end
end
