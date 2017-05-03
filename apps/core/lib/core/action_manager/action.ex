defmodule Core.ActionManager.Action do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.ActionManager.Action


  schema "action_manager_actions" do
    field :name, :string
    field :target_id, :integer
    field :target_type, :string
    field :previous_state, :map
    field :next_state, :map
    field :payload, :map
    timestamps()
  end

  @doc false
  def changeset(%Action{} = action, attrs) do
    action
    |> cast(attrs, [:name,
                    :target_id,
                    :target_type,
                    :previous_state,
                    :next_state,
                    :payload])
    |> validate_required([:name,
                          :target_id,
                          :target_type,
                          :previous_state,
                          :next_state,
                          :payload])
  end
end
