defmodule Core.Repo.Migrations.CreateEntity do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:entities, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add(:name, :string)
      add(:label, :string)
      add(:slug, :string)
      add(:description, :text)
      add(:source, :string)
      add(:service_uuid, :uuid)
      add(:entity_type_uuid, :uuid)
      add(:abilities, {:array, :binary_id})
      timestamps()
    end

    create(unique_index(:entities, [:slug]))
    create(index(:entities, [:service_uuid]))
    create(index(:entities, [:entity_type_uuid]))
  end
end
