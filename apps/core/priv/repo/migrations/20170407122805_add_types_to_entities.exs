defmodule Core.Repo.Migrations.AddTypesToEntities do
  use Ecto.Migration

  def change do
  	alter table(:service_manager_entities) do
  		add :entity_type_id, references(:service_manager_entity_types, on_delete: :nothing)
  	end
  	create index(:service_manager_entities, [:entity_type_id])
  end
end
