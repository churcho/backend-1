defmodule Core.Repo.Migrations.CreateEntityType do
  use Ecto.Migration

  def change do
    create table(:service_manager_entity_types) do
      add :name, :string
      add :description, :string

      timestamps()
    end

  end
end

