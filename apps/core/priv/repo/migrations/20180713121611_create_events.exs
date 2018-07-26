defmodule Core.Repo.Migrations.CreateEvents do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:events, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :initialized_at, :integer
      add :occured_at, :integer
      add :source, :string
      add :topic, :string
      add :transaction_id, :uuid
      add :data, :map
      add :ttl, :integer
      timestamps()
    end

  end
end
