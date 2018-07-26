defmodule Core.People.Profile do
  @moduledoc false
  use Core.BaseSchema
  import Ecto.Changeset

  schema "profiles" do
    field :username, :string
    field :first_name, :string
    field :last_name, :string

    belongs_to :user, Core.Accounts.User

    timestamps()
  end

   @doc false
   def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :username,
      :first_name,
      :last_name,
    ])
    |> validate_required([:first_name, :last_name])
  end
end
