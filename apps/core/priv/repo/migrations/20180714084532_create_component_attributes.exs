defmodule Core.Repo.Migrations.CreateComponentAttributes do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:component_attributes, primary_key: false) do
      add :attribute_id, references(:attributes, on_delete: :nothing, type: :uuid)
      add :component_id, references(:components, on_delete: :nothing, type: :uuid)
    end
    create unique_index(:component_attributes, [:component_id, :attribute_id])
  end
end
