defmodule Core.Repo.Migrations.CreateEvent do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:events) do
      add(:source, :string)
      add(:state_changed, :boolean, default: true, null: false)
      add(:payload, :map)
      add(:metadata, :map)
      add(:permissions, :map)
      timestamps()
    end
  end
end
