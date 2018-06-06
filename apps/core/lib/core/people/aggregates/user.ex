defmodule Core.People.Aggregates.User do
  @moduledoc false
  defstruct [
    :uuid,
    :username,
    :first_name,
    :last_name,
    :role_uuid,
    :email,
    :hashed_password
  ]

  alias Core.People.Aggregates.User
  alias Core.People.Commands.{
    RegisterUser,
    UpdateUser
  }
  alias Core.People.Events.{
    UserEmailChanged,
    UserUsernameChanged,
    UserFirstNameChanged,
    UserLastNameChanged,
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
      username: register.username,
      first_name: register.first_name,
      last_name: register.last_name,
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
      &username_changed/2,
      &email_changed/2,
      &first_name_changed/2,
      &last_name_changed/2,
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
      username: registered.username,
      first_name: registered.first_name,
      last_name: registered.last_name,
      role_uuid: registered.role_uuid,
      email: registered.email,
      hashed_password: registered.hashed_password,
    }
  end

  def apply(%User{} = user, %UserUsernameChanged{username: username}) do
    %User{user | username: username}
  end

  def apply(%User{} = user, %UserEmailChanged{email: email}) do
    %User{user | email: email}
  end

  def apply(%User{} = user, %UserFirstNameChanged{first_name: first_name}) do
    %User{user | first_name: first_name}
  end

  def apply(%User{} = user, %UserLastNameChanged{last_name: last_name}) do
    %User{user | last_name: last_name}
  end

  def apply(%User{} = user, %UserRoleChanged{role_uuid: role_uuid}) do
    %User{user | role_uuid: role_uuid}
  end

  def apply(%User{} = user, %UserPasswordChanged{hashed_password: hashed_password}) do
    %User{user | hashed_password: hashed_password}
  end

  # private helpers

  defp username_changed(%User{}, %UpdateUser{username: ""}), do: nil
  defp username_changed(%User{username: username}, %UpdateUser{username: username}), do: nil
  defp username_changed(%User{uuid: user_uuid}, %UpdateUser{username: username}) do
    %UserUsernameChanged{
      user_uuid: user_uuid,
      username: username,
    }
  end

  defp email_changed(%User{}, %UpdateUser{email: ""}), do: nil
  defp email_changed(%User{email: email}, %UpdateUser{email: email}), do: nil
  defp email_changed(%User{uuid: user_uuid}, %UpdateUser{email: email}) do
    %UserEmailChanged{
      user_uuid: user_uuid,
      email: email,
    }
  end

  defp first_name_changed(%User{}, %UpdateUser{first_name: ""}), do: nil
  defp first_name_changed(%User{first_name: first_name}, %UpdateUser{first_name: first_name}), do: nil
  defp first_name_changed(%User{uuid: user_uuid}, %UpdateUser{first_name: first_name}) do
    %UserFirstNameChanged{
      user_uuid: user_uuid,
      first_name: first_name,
    }
  end

  defp last_name_changed(%User{}, %UpdateUser{last_name: ""}), do: nil
  defp last_name_changed(%User{last_name: last_name}, %UpdateUser{last_name: last_name}), do: nil
  defp last_name_changed(%User{uuid: user_uuid}, %UpdateUser{last_name: last_name}) do
    %UserLastNameChanged{
      user_uuid: user_uuid,
      last_name: last_name,
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
