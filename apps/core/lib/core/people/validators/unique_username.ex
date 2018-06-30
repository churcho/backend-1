defmodule Core.People.Validators.UniqueUsername do
  @moduledoc """
  Validates uniqueness of username
  """
  use Vex.Validator

  alias Core.People
  alias Core.People.Projections.Profile

  def validate(username, context) do
    profile_uuid = Map.get(context, :profile_uuid)

    case username_registered?(username, profile_uuid) do
      true -> {:error, "has already been taken"}
      false -> :ok
    end
  end

  defp username_registered?(username, profile_uuid) do
    case People.profile_by_username(username) do
      %Profile{uuid: ^profile_uuid} -> false
      nil -> false
      _ -> true
    end
  end
end
