defmodule Core.Accounts.Projectors.User do
  @moduledoc false
  use Commanded.Projections.Ecto,
    name: "Accounts.Projectors.User",
    consistency: :strong

  alias Core.Accounts.Events.{
    UserEmailChanged,
    UserUsernameChanged,
    UserRoleChanged,
    UserPasswordChanged,
    UserRegistered,
  }
  alias Core.Accounts.Projections.User
  alias Ecto.Multi

  project %UserRegistered{} = registered do
    Multi.insert(multi, :user, %User{
      uuid: registered.user_uuid,
      username: registered.username,
      email: registered.email,
      role_uuid: registered.role_uuid,
      hashed_password: registered.hashed_password,
    })
  end

  project %UserUsernameChanged{user_uuid: user_uuid, username: username} do
    update_user(multi, user_uuid, username: username)
  end

  project %UserEmailChanged{user_uuid: user_uuid, email: email} do
    update_user(multi, user_uuid, email: email)
  end

  project %UserRoleChanged{user_uuid: user_uuid, role_uuid: role_uuid} do
    update_user(multi, user_uuid, role_uuid: role_uuid)
  end

  project %UserPasswordChanged{
    user_uuid: user_uuid,
    hashed_password: hashed_password
    }
  do
    update_user(multi, user_uuid, hashed_password: hashed_password)
  end

  defp update_user(multi, user_uuid, changes) do
    Multi.update_all(multi, :user, user_query(user_uuid), set: changes)
  end

  defp user_query(user_uuid) do
    from(u in User, where: u.uuid == ^user_uuid)
  end
end
