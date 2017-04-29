defmodule Core.AccountManager do
  @moduledoc """
  Account Manager
  """

  import Ecto.{Query, Changeset}, warn: false
  alias Core.Repo

  alias Core.AccountManager.User
  alias Core.AccountManager.Role
  alias Core.AccountManager.Setting

  @doc """
  Returns the list of users.

  ## Examples

    iex> list_users()
    [%User{}, ...]

  """
  def list_users do
    User
    |> Repo.all()
    |> Repo.preload([:role])
  end

  @doc """
  Returns the list of roles.

  ## Examples

    iex> list_roles()
    [%Role{}, ...]

  """
  def list_roles do
    User
    |> Repo.all()
    |> Repo.preload([:users])
  end

  @doc """
  Returns the list of settings.

  ## Examples

    iex> list_settings()
    [%Setting{}, ...]

  """

  def list_settings do
    Setting
    |> Repo.all()
    |> Repo.preload([:user])
  end

  @doc """
  Gets a single User.

  Raises `Ecto.NoResultsError` if the User does not exist.

    ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

 	"""

  def get_user!(id) do
    User
    |> Repo.get!(id)
  	|> Repo.preload([:role])
  end

  @doc """
  Gets a single User by Email Address.

  Raises `Ecto.NoResultsError` if the User does not exist.

    ## Examples

      iex> get_user_by_email("me@me.com")
      %User{}

      iex> get_user_by_email(456)
      ** (Ecto.NoResultsError)

 	"""
  def get_user_by_email(email) do
    User
    |> Repo.get_by(email: email)
  	|> Repo.preload([:role])
  end

  @doc """
  Gets a single Role.

  Raises `Ecto.NoResultsError` if the Role does not exist.

    ## Examples

      iex> get_role!(123)
      %Role{}

      iex> get_role!(456)
      ** (Ecto.NoResultsError)

 	"""
  def get_role!(id) do
    User
    |> Repo.get!(id)
  	|> Repo.preload([:users])
  end

  @doc """
  Gets a single Role by name.

  Raises `Ecto.NoResultsError` if the Role does not exist.

    ## Examples

      iex> get_role_by_name("name")
      %Role{}

      iex> get_role_by_name(456)
      ** (Ecto.NoResultsError)

 	"""
  def get_role_by_name(name) do
    Role
    |> Repo.get_by(name: name)
    |> Repo.preload([:users])
  end

  @doc """
  Gets a single Setting.

  Raises `Ecto.NoResultsError` if the Setting does not exist.

    ## Examples

      iex> get_setting!(123)
      %Setting{}

      iex> get_setting!(456)
      ** (Ecto.NoResultsError)

  """
  def get_setting!(id) do
    User
    |> Repo.get!(id)
    |> Repo.preload([:user])
  end

  @doc """
  Creates a user.

  ## Examples

    iex> create_user(%{field: value})
    {:ok, %user{}}

    iex> create_user(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> user_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a Role.

  ## Examples

    iex> create_role(%{field: value})
    {:ok, %Role{}}

    iex> create_role(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def create_role(attrs \\ %{}) do
    %Role{}
    |> role_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a Setting.

  ## Examples

    iex> create_setting(%{field: value})
    {:ok, %Setting{}}

    iex> create_setting(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def create_setting(attrs \\ %{}) do
    %Setting{}
    |> role_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a User.

  ## Examples

    iex> update_user(User, %{field: new_value})
    {:ok, %User{}}

    iex> update_user(User, %{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> user_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates a Role.

  ## Examples

    iex> update_role(Role, %{field: new_value})
    {:ok, %Role{}}

    iex> update_role(Role, %{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def update_role(%Role{} = role, attrs) do
    role
    |> role_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates a Setting.

  ## Examples

    iex> update_setting(Setting, %{field: new_value})
    {:ok, %Setting{}}

    iex> update_setting(Setting, %{field: bad_value})
    {:error, %Ecto.Changeset{}}

  """
  def update_setting(%Setting{} = setting, attrs) do
    setting
    |> setting_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

    iex> delete_user(User)
    {:ok, %User{}}

    iex> delete_user(User)
    {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Deletes a Role.

  ## Examples

    iex> delete_role(Role)
    {:ok, %Role{}}

    iex> delete_role(Role)
    {:error, %Ecto.Changeset{}}

  """
  def delete_role(%Role{} = role) do
    Repo.delete(role)
  end

  @doc """
  Deletes a Setting.

  ## Examples

    iex> delete_setting(Role)
    {:ok, %Setting{}}

    iex> delete_setting(Role)
    {:error, %Ecto.Changeset{}}

  """
  def delete_setting(%Setting{} = setting) do
    Repo.delete(setting)
  end


  def grant_role(user) do
    #Automatic role grant on user creation. If there is only one user,
    #Make it an admin
    role =
    case length(list_users()) do
      1 ->
        get_role_by_name("Admin")
      _ ->
        get_role_by_name("Guest")
    end

    user_params = %{role_id: role.id}

    user
    |> profile_changeset(user_params)
    |> Repo.update

  end


  defp profile_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:role_id], [])
  end

  @user_required_fields ~w(first_name last_name email password)
  @user_optional_fields ~w(encrypted_password)
  defp user_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, @user_required_fields, @user_optional_fields)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
    |> validate_confirmation(:password, message: "Password does not match")
    |> unique_constraint(:email, message: "Email already taken")
    |> generate_encrypted_password
  end

  defp role_changeset(%Role{} = role, attrs) do
    role
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end

  defp setting_changeset(%Setting{} = setting, attrs) do
    setting
    |> cast(attrs, [:name, :value, :environment, :description, :user_id])
    |> validate_required([:name, :value, :environment, :description, :user_id])
  end

  defp generate_encrypted_password(current_changeset) do
    case current_changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(current_changeset, :encrypted_password, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        current_changeset
    end
  end
end
