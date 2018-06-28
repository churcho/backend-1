defmodule Core.Accounts.Validators.UniqueUsername do
  @moduledoc """
  Validates uniqueness of username
  """
  use Vex.Validator

  alias Core.Accounts
  alias Core.Accounts.Projections.User

  def validate(username, context) do
    user_uuid = Map.get(context, :user_uuid)

    case username_registered?(username, user_uuid) do
      true -> {:error, "has already been taken"}
      false -> :ok
    end
  end

  defp username_registered?(username, user_uuid) do
    case Accounts.user_by_username(username) do
      %User{uuid: ^user_uuid} -> false
      nil -> false
      _ -> true
    end
end
end
