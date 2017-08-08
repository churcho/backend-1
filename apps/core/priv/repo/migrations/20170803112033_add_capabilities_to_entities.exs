defmodule Core.Repo.Migrations.AddCapabilitiesToEntities do
  use Ecto.Migration

  def change do
    alter table(:service_manager_entities) do
      add :capabilities, {:array, :string}
    end
  end
end
