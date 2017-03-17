defmodule Core.Repo.Migrations.AddRolesToUsers do
  use Ecto.Migration

  def change do
  	alter table(:users) do
  		add :role_id, references(:roles, on_delete: :nothing)
  		add :last_seen, :utc_datetime
  		add :enabled, :boolean, default: false, null: false
  	end
  	create index(:users, [:role_id])
  end
end
