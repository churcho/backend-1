defmodule CoreWeb.RegistrationController  do
  use CoreWeb, :controller

  alias Core.Accounts
  alias Core.Accounts.Projections.User

  action_fallback CoreWeb.FallbackController

  plug :scrub_params, "user" when action in [:create]

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.register_user(user_params) do
      {:ok, jwt, _full_claims} =
      user |> Guardian.encode_and_sign(:token)

      conn
      |> put_status(:created)
      |> render(CoreWeb.SessionView, "show.json", jwt: jwt, user: user)
    end
  end
end
