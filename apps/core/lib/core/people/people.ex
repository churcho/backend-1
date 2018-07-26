defmodule Core.People do
  @moduledoc """
  The People context.
  """

  alias Core.{Repo}

  alias Core.People.Queries.{
    ListProfiles,
    ProfileByUsername
  }

  alias Core.People.Profile

  @doc """
  List All Users
  """
  def list_profiles do
    ListProfiles.new() |> Repo.all()
  end

  @doc """
  Gets a single profile.

  Raises `Ecto.NoResultsError` if the Profile does not exist.

  ## Examples

      iex> get_profile!(123)
      %Profile{}

      iex> get_profile!(456)
      ** (Ecto.NoResultsError)

  """
  def get_profile!(id), do: Repo.get!(Profile, id)

  @doc """
  Get an existing user by their username, or return `nil` if not registered
  """
  def profile_by_username(username) when is_binary(username) do
    username
    |> String.downcase()
    |> ProfileByUsername.new()
    |> Repo.one()
  end

  @doc """
  Create an profile.
  An profile shares the same uuid as the user, but with a different prefix.
  """
  def create_profile(%{} = attrs) do
    %Profile{}
    |> Profile.changeset(attrs)
    |> Repo.insert()
  end

end
