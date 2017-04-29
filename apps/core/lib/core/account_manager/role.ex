defmodule Core.AccountManager.Role do
  @moduledoc """
  Role schema
  """
  use Core.Web, :model

  schema "roles" do
    field :name, :string
    field :description, :string

    has_many :users, Core.AccountManager.User
    timestamps()
  end
end
