defmodule Core.ProviderManager.ActionType do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.ProviderManager.ActionType
  alias Core.ProviderManager.Provider
  alias Core.ActionManager.Action

  schema "action_types" do
    field(:description, :string)
    field(:name, :string)
    field(:input, :map)

    belongs_to(:provider, Provider)
    belongs_to(:action, Action)

    timestamps()
  end

  @doc false
  def changeset(%ActionType{} = action_type, attrs) do
    action_type
    |> cast(attrs, [:name, :description, :input])
    |> validate_required([:name, :description, :input])
  end
end
