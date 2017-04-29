defmodule Core.AccountManager.User do
  @moduledoc """
  User
  """
  use Core.Web, :model


  @derive {Poison.Encoder, only: [:id, :first_name, :last_name, :email]}

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :username, :string
    field :email, :string
    field :slug, :string
    field :last_seen, :utc_datetime
    field :enabled, :boolean
    field :encrypted_password, :string
    field :password, :string, virtual: true

    belongs_to :role, Core.AccountManager.Role
    has_many :settings, Core.AccountManager.Setting
    
    timestamps()
  end
end
