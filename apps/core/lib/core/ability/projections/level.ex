defmodule Core.Ability.Projections.Level do
  @moduledoc false
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}
  schema "levels" do
    field :value, :integer

    timestamps()
  end
end
