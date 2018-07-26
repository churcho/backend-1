defmodule Core.Repo.Migrations.CreateRole do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:roles, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :label, :string
      add :description, :string

      timestamps()
    end
    create unique_index(:roles, [:name])
  end
end
