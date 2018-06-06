defmodule Core.Ability.Projections.Switch do
  @moduledoc false
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}
  schema "switches" do
    field :value, :boolean, default: false
    timestamps()
  end
end
