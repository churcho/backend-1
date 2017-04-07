defmodule Core.Repo.Migrations.CreateService do
  use Ecto.Migration

  def change do
    create table(:service_manager_services) do
      add :name, :string
      add :client_id, :string
      add :client_secret, :string
      add :access_token, :binary
      add :api_key, :string
      add :enabled, :boolean, default: true
      add :searchable, :boolean, default: false
      add :search_path, :string
      add :state, :map
      add :configuration, :map
      add :metadata, :map
      add :authorized, :boolean, default: false
      add :host, :string
      add :port, :string
      add :imported_at, :utc_datetime
      add :allows_import, :boolean, default: false
      add :requires_authorization, :boolean, default: false
      add :provider_id, references(:service_manager_providers, on_delete: :delete_all)
      add :slug, :string
      timestamps()
    end
    create index(:service_manager_services, [:provider_id])
    create unique_index(:service_manager_services, [:slug])
  end
end
