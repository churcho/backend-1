defmodule Core.Repo.Migrations.CreateService do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:services) do
      add(:name, :string)
      add(:description, :text)
      add(:client_id, :string)
      add(:client_secret, :string)
      add(:access_token, :binary)
      add(:api_key, :string)
      add(:enabled, :boolean, default: true)
      add(:state, :map)
      add(:configuration, :map)
      add(:metadata, :map)
      add(:authorized, :boolean, default: false)
      add(:host, :string)
      add(:port, :string)
      add(:imported_at, :utc_datetime)
      add(:provider_id, references(:providers, on_delete: :delete_all))
      add(:slug, :string)
      timestamps()
    end

    create(index(:services, [:provider_id]))
    create(unique_index(:services, [:slug]))
  end
end
