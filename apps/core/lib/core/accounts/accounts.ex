defmodule Core.Accounts do
  @moduledoc """
  Accounts Manager Context Boundary
  """

  alias Core.DB.{
    User,
    Role
  }

  alias Core.Accounts.Queries.{
    UserByUsername,
    UserByEmail,
    RoleByName
  }
  alias Core.Repo

  import Ecto.Query, warn: false

  @doc """
  List All Users
  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Registers a user.

  ## Examples

      iex> register_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def register_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> User.generate_encrypted_password()
    |> User.grant_role()
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Delete an Account. Returns `:ok` on success
  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
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

  # Roles

  @doc """
  List All Roles
  """
  def list_roles do
    Repo.all(Role)
  end

  @doc """
  Gets a single role

  Raises `Ecto.NoResultsError` if the Role does not exist.

  ## Examples

      iex> get_role!(123)
      %User{}

      iex> get_role!(456)
      ** (Ecto.NoResultsError)

  """
  def get_role!(id), do: Repo.get!(Role, id)

  @doc """
  Create a new Role.
  """
  def create_role(attrs \\ %{}) do
    %Role{}
    |> Role.changeset(attrs)
    |> Repo.insert()
  end


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
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
end
