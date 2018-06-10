defmodule Core.Accounts.Commands.UpdateRole do
  @moduledoc false
  defstruct [
    role_uuid: "",
    name: "",
    description: "",
    label: ""
  ]

  use ExConstructor
  use Vex.Struct

  alias Core.Accounts.Commands.UpdateRole
  alias Core.Accounts.Projections.Role
  alias Core.Accounts.Validators.{UniqueRoleName}

  validates :role_uuid, uuid: true

  validates :name,
    presence: [message: "can't be empty"],
    format: [
      with: ~r/^[a-z0-9]+$/, allow_nil: true, allow_blank: true, message: "is invalid"
    ],
    string: true,
    by: &UniqueRoleName.validate/2

  @doc """
  Assign the role identity
  """
  def assign_role(%UpdateRole{} = update_role, %Role{uuid: role_uuid}) do
    %UpdateRole{update_role | role_uuid: role_uuid}
  end

  @doc """
  Convert name to lowercase characters
  """
  def downcase_name(%UpdateRole{name: name} = update_role) do
    %UpdateRole{update_role | name: String.downcase(name)}
  end
end

defimpl Core.Support.Middleware.Uniqueness.UniqueFields,
  for: Core.Accounts.Commands.UpdateRole
do
  def unique(%Core.Accounts.Commands.UpdateRole{role_uuid: role_uuid}), do: [
    {:name, "has already been taken", role_uuid}
  ]
end
