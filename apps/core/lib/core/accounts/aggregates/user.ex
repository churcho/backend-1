defmodule Core.Accounts.Aggregates.User do
  @moduledoc false
  defstruct [
    :uuid,
    :role_uuid,
    :email,
    :hashed_password
  ]

  alias Core.Accounts.Aggregates.User
  alias Core.Accounts.Commands.{
    RegisterUser,
    UpdateUser
  }
  alias Core.Accounts.Events.{
    UserEmailChanged,
    UserRoleChanged,
    UserPasswordChanged,
    UserRegistered
  }

  @doc """
  Register a new user
  """
  def execute(%User{uuid: nil}, %RegisterUser{} = register) do
    %UserRegistered{
      user_uuid: register.user_uuid,
      role_uuid: register.role_uuid,
      email: register.email,
      hashed_password: register.hashed_password,
    }
  end

  @doc """
  Update a user's username, email, and password
  """
  def execute(%User{} = user, %UpdateUser{} = update) do
    Enum.reduce([
      &email_changed/2,
      &role_uuid_changed/2,
      &password_changed/2,
      ], [], fn (change, events) ->
      case change.(user, update) do
        nil -> events
        event -> [event | events]
      end
    end)
  end

  # state mutators

  def apply(%User{} = user, %UserRegistered{} = registered) do
    %User{user |
      uuid: registered.user_uuid,
      role_uuid: registered.role_uuid,
      email: registered.email,
      hashed_password: registered.hashed_password,
    }
  end

  def apply(%User{} = user, %UserEmailChanged{email: email}) do
    %User{user | email: email}
  end

  def apply(%User{} = user, %UserRoleChanged{role_uuid: role_uuid}) do
    %User{user | role_uuid: role_uuid}
  end

  def apply(%User{} = user, %UserPasswordChanged{hashed_password: hashed_password}) do
    %User{user | hashed_password: hashed_password}
  end

  # private helpers

  defp email_changed(%User{}, %UpdateUser{email: ""}), do: nil
  defp email_changed(%User{email: email}, %UpdateUser{email: email}), do: nil
  defp email_changed(%User{uuid: user_uuid}, %UpdateUser{email: email}) do
    %UserEmailChanged{
      user_uuid: user_uuid,
      email: email,
    }
  end

  defp role_uuid_changed(%User{}, %UpdateUser{email: ""}), do: nil
  defp role_uuid_changed(%User{role_uuid: role_uuid}, %UpdateUser{role_uuid: role_uuid}), do: nil
  defp role_uuid_changed(%User{uuid: user_uuid}, %UpdateUser{role_uuid: role_uuid}) do
    %UserRoleChanged{
      user_uuid: user_uuid,
      role_uuid: role_uuid,
    }
  end

  defp password_changed(%User{}, %UpdateUser{hashed_password: ""}), do: nil
  defp password_changed(%User{hashed_password: hashed_password}, %UpdateUser{hashed_password: hashed_password}), do: nil
  defp password_changed(%User{uuid: user_uuid}, %UpdateUser{hashed_password: hashed_password}) do
    %UserPasswordChanged{
      user_uuid: user_uuid,
      hashed_password: hashed_password,
    }
  end
end
