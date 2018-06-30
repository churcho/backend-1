defmodule Core.Auth.GuardianSerializer do
  @moduledoc """
  Guardian Helper
  """
  @behaviour Guardian.Serializer

  alias Core.Accounts
  alias Core.Accounts.Projections.User

  def for_token(user = %User{}), do: {:ok, "User:#{user.uuid}"}
  def for_token(_), do: {:error, "Unknown resource type"}

  def from_token("User:" <> uuid), do: {:ok, Accounts.user_by_uuid(uuid)}
  def from_token(_), do: {:error, "Unknown resource type"}
end
