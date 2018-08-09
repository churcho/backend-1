defmodule Core.DB.Profile do
  @moduledoc false
  use Core.BaseSchema
  import Ecto.Changeset
  alias Core.DB.User

  schema "profiles" do
    field :username, :string
    field :first_name, :string
    field :last_name, :string

    belongs_to :user, User

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
