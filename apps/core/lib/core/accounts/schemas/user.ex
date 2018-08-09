defmodule Core.DB.User do
  @moduledoc false
  use Core.BaseSchema
  import Ecto.Changeset
  alias Core.Accounts
  alias Core.DB.{
    Role,
    Profile,
  }

  schema "users" do
    field :username, :string, unique: true
    field :email, :string, unique: true
    field :last_seen, :utc_datetime
    field :enabled, :boolean
    field :password, :string, virtual: true
    field :hashed_password, :string
    has_one :profile, Profile
    belongs_to :role, Role
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :username,
      :email,
      :last_seen,
      :enabled,
      :password,
      :role_id,
      :hashed_password
    ])
    |> validate_required([:username, :email])
  end


  def generate_encrypted_password(current_changeset) do
    case current_changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(current_changeset, :hashed_password, Core.Auth.hash_password(password))
      _ ->
        current_changeset
    end
  end

  def grant_role(current_changeset) do
    case current_changeset do
      %Ecto.Changeset{valid?: true, changes: %{}} ->
        put_change(current_changeset, :role_id, resolve_role())
      _ ->
        current_changeset
    end
  end


  defp resolve_role do
    role =
    case length(Accounts.list_users) do
      0 ->
        Accounts.role_by_name("admin")
      _ ->
        Accounts.role_by_name("guest")
    end

    role.id
  end
end
