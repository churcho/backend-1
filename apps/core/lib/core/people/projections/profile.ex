defmodule Core.People.Projections.Profile do
  @moduledoc false
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}
  schema "profiles" do
    field :username, :string
    field :first_name, :string
    field :last_name, :string
    field :user_uuid, :binary_id

    timestamps()
  end
end
