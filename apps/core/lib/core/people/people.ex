defmodule Core.People do
  @moduledoc """
  The People context.
  """

  alias Core.{
    Repo,
    Router
  }

  alias Core.People.Commands.{
    CreateProfile
  }

  alias Core.People.Queries.{
    ListProfiles
  }

  alias Core.People.Projections.Profile

  @doc """
  List All Users
  """
  def list_profiles do
    ListProfiles.new() |> Repo.all()
  end

  @doc """
  Get a single profile by its UUID
  """
  def profile_by_uuid(uuid) when is_binary(uuid) do
    Repo.get(Profile, uuid)
  end

  @doc """
  Create an profile.
  An profile shares the same uuid as the user, but with a different prefix.
  """
  def create_profile(%{user_uuid: uuid} = attrs) do
    create_profile =
      attrs
      |> CreateProfile.new()
      |> CreateProfile.assign_uuid(uuid)

    with :ok <- Router.dispatch(create_profile, consistency: :strong) do
      get(Profile, uuid)
    else
      reply -> reply
    end
  end

  defp get(schema, uuid) do
    case Repo.get(schema, uuid) do
      nil -> {:error, :not_found}
      projection -> {:ok, projection}
    end
  end
end
