defmodule Core.Repo.Migrations.CreateProvider do
  use Ecto.Migration

  def change do
    create table(:service_manager_providers) do
      add :name, :string
      add :description, :string
      add :url, :string
      add :enabled, :boolean, default: true
      add :lorp_name, :string
      add :auth_method, :string
      add :registered_at, :utc_datetime
      add :last_seen, :utc_datetime
      add :provides, :map
      add :max_services, :integer
      add :configuration, :map
      add :version, :string
      add :keywords, {:array, :string}
      add :logo_path, :string
      add :icon_path, :string
      add :slug, :string

      timestamps()
    end
    create unique_index(:service_manager_providers, [:slug])
  end
end
