defmodule Core.People.Aggregates.Profile do
  @moduledoc false
  defstruct [
    :uuid,
    :user_uuid,
    :username,
    :first_name,
    :last_name
  ]

  alias Core.People.Aggregates.Profile
  alias Core.People.Commands.{
    CreateProfile,
    UpdateProfile
  }
  alias Core.People.Events.{
    ProfileUsernameChanged,
    ProfileFirstNameChanged,
    ProfileLastNameChanged,
    ProfileCreated
  }

  @doc """
  Create a new Profile
  """
  def execute(%Profile{uuid: nil}, %CreateProfile{} = create) do
    %ProfileCreated{
      profile_uuid: create.profile_uuid,
      user_uuid: create.user_uuid,
      username: create.username,
      first_name: create.first_name,
      last_name: create.last_name,
    }
  end

  @doc """
  Update a profile's name, first_name, and last_name
  """
  def execute(%Profile{} = profile, %UpdateProfile{} = update) do
    Enum.reduce([
      &username_changed/2,
      &first_name_changed/2,
      &last_name_changed/2
      ], [], fn (change, events) ->
      case change.(profile, update) do
        nil -> events
        event -> [event | events]
      end
    end)
  end

  # state mutators

  def apply(%Profile{} = profile, %ProfileCreated{} = created) do
    %Profile{profile |
      uuid: created.profile_uuid,
      user_uuid: created.user_uuid,
      username: created.username,
      first_name: created.first_name,
      last_name: created.last_name,
    }
  end

  def apply(%Profile{} = profile, %ProfileUsernameChanged{username: username}) do
    %Profile{profile | username: username}
  end

  def apply(%Profile{} = profile, %ProfileLastNameChanged{last_name: last_name}) do
    %Profile{profile | last_name: last_name}
  end

  def apply(%Profile{} = profile, %ProfileFirstNameChanged{first_name: first_name}) do
    %Profile{profile | first_name: first_name}
  end

  # private helpers

  defp username_changed(%Profile{}, %UpdateProfile{username: ""}), do: nil
  defp username_changed(%Profile{username: username}, %UpdateProfile{username: username}), do: nil
  defp username_changed(%Profile{uuid: profile_uuid}, %UpdateProfile{username: username}) do
    %ProfileUsernameChanged{
      profile_uuid: profile_uuid,
      username: username,
    }
  end

  defp first_name_changed(%Profile{}, %UpdateProfile{first_name: ""}), do: nil
  defp first_name_changed(%Profile{first_name: first_name}, %UpdateProfile{first_name: first_name}), do: nil
  defp first_name_changed(%Profile{uuid: profile_uuid}, %UpdateProfile{first_name: first_name}) do
    %ProfileFirstNameChanged{
      profile_uuid: profile_uuid,
      first_name: first_name,
    }
  end

  defp last_name_changed(%Profile{}, %UpdateProfile{last_name: ""}), do: nil
  defp last_name_changed(%Profile{last_name: last_name}, %UpdateProfile{last_name: last_name}), do: nil
  defp last_name_changed(%Profile{uuid: profile_uuid}, %UpdateProfile{last_name: last_name}) do
    %ProfileLastNameChanged{
      profile_uuid: profile_uuid,
      last_name: last_name,
    }
  end
end
