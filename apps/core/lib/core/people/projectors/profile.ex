defmodule Core.People.Projectors.Profile do
  @moduledoc false
  use Commanded.Projections.Ecto,
    name: "People.Projectors.Profile",
    consistency: :strong

  alias Core.People.Events.{
    ProfileUsernameChanged,
    ProfileFirstNameChanged,
    ProfileLastNameChanged,
    ProfileUserChanged,
    ProfileCreated,
  }
  alias Core.People.Projections.Profile
  alias Ecto.Multi

  project %ProfileCreated{} = created do
    Multi.insert(multi, :profile, %Profile{
      uuid: created.profile_uuid,
      username: created.username,
      first_name: created.first_name,
      last_name: created.last_name,
      user_uuid: created.user_uuid,
    })
  end

  project %ProfileUsernameChanged{
    profile_uuid: profile_uuid,
    username: username
  }
  do
    update_profile(multi, profile_uuid, username: username)
  end

  project %ProfileFirstNameChanged{
    profile_uuid: profile_uuid,
    first_name: first_name
    }
  do
    update_profile(multi, profile_uuid, first_name: first_name)
  end

  project %ProfileLastNameChanged{
    profile_uuid: profile_uuid, last_name: last_name}
  do
    update_profile(multi, profile_uuid, last_name: last_name)
  end

  project %ProfileUserChanged{profile_uuid: profile_uuid, user_uuid: user_uuid} do
    update_profile(multi, profile_uuid, user_uuid: user_uuid)
  end

  defp update_profile(multi, profile_uuid, changes) do
    Multi.update_all(multi, :profile, profile_query(profile_uuid), set: changes)
  end

  defp profile_query(profile_uuid) do
    from(p in Profile, where: p.uuid == ^profile_uuid)
  end
end
