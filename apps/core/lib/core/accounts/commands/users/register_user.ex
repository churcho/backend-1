defmodule Core.Accounts.Commands.RegisterUser do
@moduledoc """
Register User Command
"""

  defstruct [
    user_uuid: "",
    email: "",
    password: "",
    hashed_password: "",
    role_uuid: ""
  ]

  use ExConstructor
  use Vex.Struct

  alias Core.Accounts.Commands.RegisterUser
  alias Core.Accounts.Validators.{UniqueEmail}
  alias Core.Accounts
  alias Core.Auth

  validates :user_uuid, uuid: true

  validates :email,
      presence: [message: "can't be empty"],
      format: [
        with: ~r/\S+@\S+\.\S+/, allow_nil: true, allow_blank: true, message: "is invalid"
        ],
      string: true,
      by: &UniqueEmail.validate/2

  validates :hashed_password, presence: [message: "can't be empty"], string: true

  @doc """
  Assign a unique identity for the user
  """
  def assign_uuid(%RegisterUser{} = register_user, uuid) do
    %RegisterUser{register_user | user_uuid: uuid}
  end

  @doc """
  Convert email address to lowercase characters
  """
  def downcase_email(%RegisterUser{email: email} = register_user) do
    %RegisterUser{register_user | email: String.downcase(email)}
  end

  @doc """
  Grant default role
  """
  def grant_role(%RegisterUser{} = register_user) do
    role =
    case length(Accounts.list_users) do
      0 ->
        Accounts.role_by_name("admin")
      _ ->
        Accounts.role_by_name("guest")
    end

    %RegisterUser{register_user | role_uuid: role.uuid}
  end

  @doc """
  Hash the password, clear the original password
  """
  def hash_password(%RegisterUser{password: password} = register_user) do
    %RegisterUser{register_user |
      password: nil,
      hashed_password: Auth.hash_password(password),
    }
  end

  defimpl Core.Support.Middleware.Uniqueness.UniqueFields,
    for: Core.Accounts.Commands.RegisterUser
  do
    def unique(%Core.Accounts.Commands.RegisterUser{user_uuid: user_uuid}), do: [
      {:email, "has already been taken", user_uuid},
    ]
  end
end
