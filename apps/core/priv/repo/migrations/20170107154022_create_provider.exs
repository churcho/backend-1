defmodule Core.Repo.Migrations.CreateProvider do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:providers, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add(:name, :string)
      add(:description, :text)
      add(:url, :string)
      add(:enabled, :boolean, default: true)
      add(:auth_method, :string)
      add(:max_services, :integer)
      add(:service_name, :string)
      add(:allows_import, :boolean, default: false)
      add(:version, :string)
      add(:required_fields, {:array, :map})
      add(:commands, {:array, :map})
      add(:keywords, {:array, :string})
      add(:logo_path, :string)
      add(:icon_path, :string)
      add(:slug, :string)

      timestamps()
    end

    create(unique_index(:providers, [:slug]))
    create(unique_index(:providers, [:name]))
    create(unique_index(:providers, [:service_name]))
  end
end
