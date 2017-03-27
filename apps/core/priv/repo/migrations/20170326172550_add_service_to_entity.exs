defmodule Core.Repo.Migrations.AddServiceToEntity do
  use Ecto.Migration

  def change do
  	alter table(:entities) do
  		add :service_id, references(:services, on_delete: :nothing)
  		add :configuration, :map
  		add :source, :string
  		add :display_name, :string
  		
  	end
  end
end
