defmodule Core.Accounts.Validators.UniqueRoleName do
  @moduledoc """
  Validates uniqueness of a role name
  """
  use Vex.Validator

  alias Core.Accounts
  alias Core.Accounts.Projections.Role

  def validate(name, context) do
    role_uuid = Map.get(context, :role_uuid)

    case name_registered?(name, role_uuid) do
      true -> {:error, "has already been taken"}
      false -> :ok
    end
  end

  defp name_registered?(name, role_uuid) do
    case Accounts.role_by_name(name) do
      %Role{uuid: ^role_uuid} -> false
      nil -> false
      _ -> true
    end
  end
end
