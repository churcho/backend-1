defmodule Core.Repo.Migrations.CreateConnection do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:connections, primary_key: false) do
      add(:id, :uuid, primary_key: true)
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
      add(:slug, :string)

      add :provider_id, references(:providers, on_delete: :nothing, type: :uuid)
      timestamps()
    end

    create(index(:connections, [:provider_id]))
    create(unique_index(:connections, [:slug, :name]))
  end
end
