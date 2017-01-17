defmodule Iotapi.Repo.Migrations.AddDateToEvents do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :date, :utc_datetime 
    end
  end
end
