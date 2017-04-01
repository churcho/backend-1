defmodule Core.Repo.Migrations.CreateService do
  use Ecto.Migration

  def change do
    create table(:services) do
      add :name, :string
      add :client_id, :string
      add :client_secret, :string
      add :access_token, :binary
      add :api_key, :string
      add :enabled, :boolean, default: true
      add :searchable, :boolean, default: false
      add :search_path, :string
      add :state, :map
      add :provider_id, references(:providers, on_delete: :delete_all)
      add :slug, :string
      timestamps()
    end
    create index(:services, [:provider_id])
    create unique_index(:services, [:slug])
  end
end
