defmodule Core.Repo.Migrations.CreateRole do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:roles, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :name, :string
      add :label, :string
      add :description, :string
      add :users, {:array, :binary_id}

      timestamps()
    end
    create unique_index(:roles, [:name])
  end
end
