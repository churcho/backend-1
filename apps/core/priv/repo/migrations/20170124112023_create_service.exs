defmodule Core.Repo.Migrations.CreateService do
  use Ecto.Migration

  def change do
    create table(:services) do
      add :name, :string
      add :client_id, :string
      add :client_secret, :string
      add :access_token, :binary
      add :url, :string
      add :oauth, :boolean, default: false, null: false
      add :bridge, :boolean, default: false, null: false
      add :enabled, :boolean, default: false, null: false
      add :type, :string
      add :search_path, :string
      add :service_state, :map
      add :provider_id, references(:providers, on_delete: :delete_all)
      timestamps()
    end
    create index(:services, [:provider_id])
  end
end
