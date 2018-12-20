defmodule Core.DB.Job do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.Types.AtomType

  schema "jobs" do
    field :name, AtomType
    field :cron_string, :string
    field :target_type, :string
    field :target_uuid, :binary_id
    field :command_string, :string
    field :command_arguments, {:array, :string}
    field :time_zone, :string
    field :last_run, :utc_datetime


    timestamps()
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [
      :name,
      :cron_string,
      :command_string,
      :last_run,
      :time_zone
    ])
    |> validate_required([
      :name,
      :cron_string,
      :command_string,
      :time_zone
      ])
  end
end
