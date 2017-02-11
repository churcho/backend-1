defmodule Iotapi.Repo.Migrations.CreateProvider do
  use Ecto.Migration

  def change do
    create table(:providers) do
      add :name, :string
      add :uri, :string
      add :callback_uri, :string

      timestamps()
    end

  end
end
