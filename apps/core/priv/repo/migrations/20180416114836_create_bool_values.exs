defmodule Core.Repo.Migrations.CreateBoolValues do
  use Ecto.Migration

  def change do
    create table(:bool_values) do
      add :values, {:array, :boolean}
      add :property_id, references(:properties, on_delete: :nothing)

      timestamps()
    end

    create index(:bool_values, [:property_id])
  end
end
