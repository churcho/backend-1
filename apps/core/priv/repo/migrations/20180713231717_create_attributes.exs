defmodule Core.Repo.Migrations.CreateAttributes do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:attributes, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :description, :string
      add :type, :string
      add :enum, {:array, :string}
      add :units, {:array, :string}
      add :min, :integer
      add :max, :integer
      add :read_only, :boolean, deafult: true, null: false
      timestamps()
    end
    create unique_index(:attributes, [:name])
  end
end
