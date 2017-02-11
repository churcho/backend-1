defmodule Iotapi.Repo.Migrations.AddProviderToServices do
  use Ecto.Migration

  def change do
    alter table(:services) do
      add :provider_id, references(:providers, on_delete: :delete_all)
    end
    create index(:services, [:provider_id])
  end
end
