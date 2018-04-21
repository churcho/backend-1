defmodule Core.Repo.Migrations.CreateCore.ActionManager.Action do
  @moduledoc false

  use Ecto.Migration

  def change do
    create table(:actions) do
      add(:time_requested, :utc_datetime)
      add(:time_completed, :utc_datetime)
      add(:status, :string)
      add(:payload, :map)
      timestamps()
    end
  end
end
