defmodule CoreWeb.Session do
  @moduledoc """
  Session Helper
  """
  alias Core.People
  alias Comeonin.Bcrypt

  def authenticate(%{"email" => email, "password" => password}) do
    user = People.user_by_email(email)

    case check_password(user, password) do
      true -> {:ok, user}
      _ -> :error
    end
  end

  defp check_password(user, password) do
    case user do
      nil -> Bcrypt.dummy_checkpw()
      _ -> Bcrypt.checkpw(password, user.hashed_password)
    end
  end
end
