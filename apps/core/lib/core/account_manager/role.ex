defmodule Core.AccountManager.Role do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.AccountManager.Role


  schema "roles" do
    field :name, :string
    field :description, :string

    has_many :users, Core.AccountManager.User
    timestamps()
  end

  def changeset(%Role{} = role, attrs) do
    role
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
