defmodule CoreWeb.RegistrationController  do
  use CoreWeb, :controller

  alias Core.Accounts
  alias Core.DB.User
  alias CoreWeb.Guardian

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.register_user(user_params),
    {:ok, token, _claims} <- Guardian.encode_and_sign(user) do

    conn |> render(CoreWeb.SessionView, "show.json", jwt: token, user: user)
    end
  end
end
