defmodule Core.AccountManager.User do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.AccountManager.User
  alias Comeonin.Bcrypt

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :username, :string
    field :email, :string
    field :slug, :string
    field :last_seen, :utc_datetime
    field :enabled, :boolean
    field :encrypted_password, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    belongs_to :role, Core.AccountManager.Role
    has_many :settings, Core.AccountManager.Setting

    timestamps()
  end

  def profile_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:role_id], [])
  end

  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
      ])
    |> validate_required([
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
      ])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
    |> validate_confirmation(:password, message: "Password does not match")
    |> unique_constraint(:email, message: "Email already taken")
    |> generate_encrypted_password
  end

  defp generate_encrypted_password(current_changeset) do
    case current_changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(
          current_changeset,
          :encrypted_password,
          Bcrypt.hashpwsalt(password)
          )
      _ ->
        current_changeset
    end
  end
end
