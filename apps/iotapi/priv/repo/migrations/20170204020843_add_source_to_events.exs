defmodule Iotapi.Repo.Migrations.AddSourceToEvents do
  use Ecto.Migration

  def change do
    alter table(:events) do
       add :source, :string
    end
  end
end
