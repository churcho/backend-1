defmodule Core.ServiceManager.ActionType do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.ServiceManager.Service
  alias Core.ServiceManager.ActionType
  alias Core.ActionManager.Action

  schema "action_types" do
    field(:description, :string)
    field(:name, :string)
    field(:input, :map)

    belongs_to(:service, Service)
    belongs_to(:action, Action)

    timestamps()
  end

  @doc false
  def changeset(%ActionType{} = action_type, attrs) do
    action_type
    |> cast(attrs, [:service_id, :action_id, :name, :description, :input])
    |> validate_required([:name, :description, :input])
  end
end
