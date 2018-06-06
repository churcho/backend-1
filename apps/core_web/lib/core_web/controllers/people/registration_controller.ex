defmodule CoreWeb.RegistrationController  do
  use CoreWeb, :controller

  alias Core.People
  alias Core.People.Projections.User

  action_fallback CoreWeb.FallbackController

  plug :scrub_params, "user" when action in [:create]

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- People.register_user(user_params) do
      {:ok, jwt, _full_claims} =
      user |> Guardian.encode_and_sign(:token)
      IO.inspect user

      conn
      |> put_status(:created)
      |> render(CoreWeb.SessionView, "show.json", jwt: jwt, user: user)
    end
  end
end
