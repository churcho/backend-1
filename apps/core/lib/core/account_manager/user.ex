defmodule Core.User do
  @moduledoc """
  User
  """
  use Core.Web, :model


  @derive {Poison.Encoder, only: [:id, :first_name, :last_name, :email]}

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

    belongs_to :role, Core.Role
    timestamps()
  end


  @required_fields ~w(first_name last_name email password)
  @optional_fields ~w(encrypted_password)

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
    |> validate_confirmation(:password, message: "Password does not match")
    |> unique_constraint(:email, message: "Email already taken")
    |> generate_encrypted_password
  end

  @doc """
  Update user profile without providing a password
  """
  def changeset_profile(struct, params \\ %{}) do
    struct
    |> cast(params, [:role_id], [])
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
