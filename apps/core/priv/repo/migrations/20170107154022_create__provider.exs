defmodule Core.Repo.Migrations.CreateProvider do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:providers) do
      add(:name, :string)
      add(:description, :text)
      add(:url, :string)
      add(:enabled, :boolean, default: true)
      add(:searchable, :boolean, default: true)
      add(:lorp_name, :string)
      add(:auth_method, :string)
      add(:registered_at, :utc_datetime)
      add(:last_seen, :utc_datetime)
      add(:provides, {:array, :map})
      add(:max_services, :integer)
      add(:configuration, :map)
      add(:allows_import, :boolean, default: false)
      add(:version, :string)
      add(:keywords, {:array, :string})
      add(:logo_path, :string)
      add(:icon_path, :string)
      add(:slug, :string)

      timestamps()
    end

    create(unique_index(:providers, [:slug]))
  end
end
