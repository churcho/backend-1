defmodule Core.Repo.Migrations.CreateService do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:services, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add(:name, :string)
      add(:description, :text)
      add(:client_id, :string)
      add(:client_secret, :string)
      add(:access_token, :binary)
      add(:api_key, :string)
      add(:enabled, :boolean, default: true)
      add(:authorized, :boolean, default: false)
      add(:host, :string)
      add(:port, :string)
      add(:provider_uuid, :uuid)
      add(:slug, :string)
      timestamps()
    end

    create(index(:services, [:provider_uuid]))
    create(unique_index(:services, [:slug, :name]))
  end
end
