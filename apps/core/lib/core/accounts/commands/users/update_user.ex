defmodule Core.Accounts.Commands.UpdateUser do
  @moduledoc false
  defstruct [
    user_uuid: "",
    email: "",
    password: "",
    hashed_password: "",
    role_uuid: ""
  ]

  use ExConstructor
  use Vex.Struct

  alias Core.Accounts.Commands.UpdateUser
  alias Core.Accounts.Projections.User
  alias Core.Accounts.Validators.{UniqueEmail}
  alias Core.Auth

  validates :user_uuid, uuid: true

  validates :email,
    presence: [message: "can't be empty"],
    format: [with: ~r/\S+@\S+\.\S+/, allow_nil: true, allow_blank: true, message: "is invalid"],
    string: true,
    by: &UniqueEmail.validate/2

  validates :hashed_password, string: [allow_nil: true, allow_blank: true]

  @doc """
  Assign the user identity
  """
  def assign_user(%UpdateUser{} = update_user, %User{uuid: user_uuid}) do
    %UpdateUser{update_user | user_uuid: user_uuid}
  end

  @doc """
  Convert email address to lowercase characters
  """
  def downcase_email(%UpdateUser{email: email} = update_user) do
    %UpdateUser{update_user | email: String.downcase(email)}
  end

  @doc """
  Hash the password, clear the original password
  """
  def hash_password(%UpdateUser{password: ""} = update_user), do: update_user
  def hash_password(%UpdateUser{password: password} = update_user) do
    %UpdateUser{update_user |
      password: nil,
      hashed_password: Auth.hash_password(password),
    }
  end
end

defimpl Core.Support.Middleware.Uniqueness.UniqueFields,
  for: Core.Accounts.Commands.UpdateUser
do
  def unique(%Core.Accounts.Commands.UpdateUser{user_uuid: user_uuid}), do: [
    {:email, "has already been taken", user_uuid},
  ]
end
