defmodule Core.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :subject, :string
      add :payload, :map
      add :entity_id, references(:service_manager_entities, on_delete: :nothing)

      timestamps()
    end

    create index(:messages, [:entity_id])
  end
end
