defmodule Core.ActionManager.Action do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.ActionManager.Action

  schema "actions" do
    field(:time_requested, :utc_datetime)
    field(:time_completed, :utc_datetime)
    field(:status, :string)
    field(:payload, :map)
    timestamps()
  end

  @doc false
  def changeset(%Action{} = action, attrs) do
    action
    |> cast(attrs, [:time_requested, :time_completed, :status, :payload])
    |> validate_required([:time_requested, :status, :payload])
  end
end
