defmodule Core.People do
  @moduledoc """
  People Manager
  """

  alias Core.People.Commands.{RegisterUser, UpdateUser, CreateRole}
  alias Core.People.Projections.{User, Role}
  alias Core.People.Queries.{
    UserByUsername,
    UserByEmail,
    RoleByName,
    ListRoles,
    ListUsers
  }
  alias Core.{Repo, Router}

  @doc """
  List All Users
  """
  def list_users do
    ListUsers.new() |> Repo.all()
  end

  @doc """
  Register a new user.
  """
  def register_user(attrs \\ %{}) do
    uuid = UUID.uuid4()

    register_user =
      attrs
      |> RegisterUser.new()
      |> RegisterUser.assign_uuid(uuid)
      |> RegisterUser.downcase_username()
      |> RegisterUser.downcase_email()
      |> RegisterUser.hash_password()
      |> RegisterUser.grant_role()

    with :ok <- Router.dispatch(register_user, consistency: :strong) do
      get(User, uuid)
    else
      reply -> reply
    end
  end

  @doc """
  Create a new Role.
  """
  def create_role(attrs \\ %{}) do
    uuid = UUID.uuid4()

    create_role =
      attrs
      |> CreateRole.new()
      |> CreateRole.assign_uuid(uuid)
      |> CreateRole.downcase_name()

    with :ok <- Router.dispatch(create_role, consistency: :strong) do
      get(Role, uuid)
    else
      reply -> reply
    end
  end

  @doc """
  Update the email, username, and/or password of a user.
  """
  def update_user(%User{uuid: user_uuid} = user, attrs \\ %{}) do
    update_user =
      attrs
      |> UpdateUser.new()
      |> UpdateUser.assign_user(user)
      |> UpdateUser.downcase_username()
      |> UpdateUser.downcase_email()
      |> UpdateUser.hash_password()

    with :ok <- Router.dispatch(update_user, consistency: :strong) do
      get(User, user_uuid)
    else
      reply -> reply
    end
  end

  @doc """
  Get an existing user by their username, or return `nil` if not registered
  """
  def user_by_username(username) when is_binary(username) do
    username
    |> String.downcase()
    |> UserByUsername.new()
    |> Repo.one()
  end

  @doc """
  Get an existing user by their email address, or return `nil` if not registered
  """
  def user_by_email(email) when is_binary(email) do
    email
    |> String.downcase()
    |> UserByEmail.new()
    |> Repo.one()
  end

  @doc """
  Get a single user by their UUID
  """
  def user_by_uuid(uuid) when is_binary(uuid) do
    Repo.get(User, uuid)
  end

  # Roles

  @doc """
  Get an existing role its name, or return `nil` if not registered
  """
  def role_by_name(name) when is_binary(name) do
    name
    |> String.downcase()
    |> RoleByName.new()
    |> Repo.one()
  end

  @doc """
  Get a single role by its UUID
  """
  def role_by_uuid(uuid) when is_binary(uuid) do
    Repo.get(Role, uuid)
  end

  @doc """
  List All Roles
  """
  def list_roles do
    ListRoles.new() |> Repo.all()
  end

  defp get(schema, uuid) do
    case Repo.get(schema, uuid) do
      nil -> {:error, :not_found}
      projection -> {:ok, projection}
    end
  end
end
