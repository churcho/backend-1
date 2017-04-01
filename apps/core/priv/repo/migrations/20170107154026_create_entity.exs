defmodule Core.Repo.Migrations.CreateEntity do
  use Ecto.Migration

  def change do
    create table(:entities) do
      add :name, :string
      add :uuid, :string
      add :description, :string
      add :label, :string
      add :metadata, :map
      add :state, :map
      add :slug, :string
      add :configuration, :map
      add :source, :string
      add :display_name, :string
      add :service_id, references(:services, on_delete: :delete_all)
      timestamps()
    end
    create unique_index(:entities, [:slug])
    create index(:entities, [:service_id])
  end
end
