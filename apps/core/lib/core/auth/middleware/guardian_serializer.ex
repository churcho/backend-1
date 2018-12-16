defmodule Core.Auth.GuardianSerializer do
  @moduledoc """
  Guardian Helper
  """
  @behaviour Guardian.Serializer

  alias Core.Accounts
  alias Core.DB.User

  def for_token(user = %User{}), do: {:ok, "User:#{user.id}"}
  def for_token(_), do: {:error, "Unknown resource type"}

  def from_token(id), do: {:ok, Accounts.get_user!(id)}
end
