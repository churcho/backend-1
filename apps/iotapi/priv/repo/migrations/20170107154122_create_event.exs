defmodule Iotapi.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :message, :string
      add :entity, :string
      add :type, :string
      add :payload, :map

      timestamps()
    end

  end
end
