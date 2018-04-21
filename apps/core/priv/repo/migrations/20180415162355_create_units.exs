defmodule Core.Repo.Migrations.CreateUnits do
  use Ecto.Migration

  def change do
    create table(:units) do
      add :name, :string
      add :description, :string
      add :symbol, :string
      add :symbols, {:array, :string}
      add :property_id, references(:properties, on_delete: :nothing)

      timestamps()
    end

    create index(:units, [:property_id])
  end
end
