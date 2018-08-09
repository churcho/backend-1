defmodule Core.Repo.Migrations.CreateComponents do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:components, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :label, :string
      add :state, :map
      timestamps()
    end
  end
end
