defmodule Core.Repo.Migrations.CreateProfile do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:profiles, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :username, :string
      add :first_name, :string
      add :last_name, :string
      add :user_uuid, :uuid

      timestamps()
    end

  end
end
