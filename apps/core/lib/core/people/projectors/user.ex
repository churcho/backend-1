defmodule Core.People.Projectors.User do
  @moduledoc false
  use Commanded.Projections.Ecto,
    name: "People.Projectors.User",
    consistency: :strong

  alias Core.People.Events.{
    UserEmailChanged,
    UserUsernameChanged,
    UserFirstNameChanged,
    UserLastNameChanged,
    UserRoleChanged,
    UserPasswordChanged,
    UserRegistered,
  }
  alias Core.People.Projections.User
  alias Ecto.Multi

  project %UserRegistered{} = registered do
    Multi.insert(multi, :user, %User{
      uuid: registered.user_uuid,
      username: registered.username,
      first_name: registered.first_name,
      last_name: registered.last_name,
      email: registered.email,
      role_uuid: registered.role_uuid,
      hashed_password: registered.hashed_password,
    })
  end

  project %UserUsernameChanged{user_uuid: user_uuid, username: username} do
    update_user(multi, user_uuid, username: username)
  end

  project %UserFirstNameChanged{user_uuid: user_uuid, first_name: first_name} do
    update_user(multi, user_uuid, first_name: first_name)
  end

  project %UserLastNameChanged{user_uuid: user_uuid, last_name: last_name} do
    update_user(multi, user_uuid, last_name: last_name)
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
