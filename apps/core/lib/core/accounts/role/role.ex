defmodule Core.Accounts.Role do
  @moduledoc false
  use Core.BaseSchema
  import Ecto.Changeset

  schema "roles" do
    field :name, :string
    field :description, :string
    field :label, :string
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :name,
      :description,
      :label
    ])
    |> validate_required([:name, :description])
  end
end
