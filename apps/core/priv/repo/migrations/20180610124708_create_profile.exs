defmodule Core.Repo.Migrations.CreateProfile do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:profiles, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :username, :string
      add :first_name, :string
      add :last_name, :string

      add :user_id, references(:users, on_delete: :nothing, type: :uuid)
      timestamps()
    end

  end
end
