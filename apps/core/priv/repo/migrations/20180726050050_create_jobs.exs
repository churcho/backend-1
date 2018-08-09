defmodule Core.Repo.Migrations.CreateJobs do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :name, :string
      add :cron_string, :string
      add :target_type, :string
      add :target_uuid, :binary_id
      add :command_string, :string
      add :command_arguments, {:array, :string}
      add :time_zone, :string
      add :last_run, :utc_datetime
      timestamps()
    end

  end
end
