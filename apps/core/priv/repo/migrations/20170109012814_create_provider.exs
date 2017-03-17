defmodule Core.Repo.Migrations.CreateProvider do
  use Ecto.Migration

  def change do
    create table(:providers) do
      add :name, :string
      add :description, :string
      add :url, :string
      add :enabled, :boolean, default: true
      add :lorp_name, :string
      add :registered_at, :utc_datetime
      add :last_seen, :utc_datetime
      add :provides, :map
      add :configuration, :map
      add :version, :string
      add :keywords, {:array, :string}
      add :searchable, :boolean, default: false
      add :search_path, :string, default: "/search"
      add :state, :map
      add :logo_path, :string
      add :icon_path, :string
      add :slug, :string

      timestamps()
    end
    create unique_index(:providers, [:slug])
  end
end
