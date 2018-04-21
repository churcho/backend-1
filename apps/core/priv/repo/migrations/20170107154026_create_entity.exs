defmodule Core.Repo.Migrations.CreateEntity do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:entities) do
      add(:name, :string)
      add(:display_name, :string)
      add(:label, :string)
      add(:slug, :string)
      add(:description, :string)
      add(:source, :string)
      add(:uuid, :string)
      add(:metadata, :map)
      add(:state, :map)
      add(:configuration, :map)

      add(:service_id, references(:services, on_delete: :delete_all))
      add(:entity_type_id, references(:entity_types, on_delete: :nothing))
      timestamps()
    end

    create(unique_index(:entities, [:slug]))
    create(index(:entities, [:service_id]))
    create(index(:entities, [:entity_type_id]))
  end
end
