defmodule Iotapi.Repo.Migrations.CreateProvider do
  use Ecto.Migration

  def change do
    create table(:providers) do
      add :name, :string
      add :description, :string
      add :uri, :string
      add :enabled, :boolean, default: true
      add :lorp_name, :string
      add :registered_at, :utc_datetime
      add :last_seen, :utc_datetime
      add :provides, :map
      add :configuration, :map
      add :keywords, :string
      add :version, :string

      timestamps()
    end

  end
end
