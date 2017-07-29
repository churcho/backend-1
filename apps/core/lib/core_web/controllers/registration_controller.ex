defmodule CoreWeb.RegistrationController  do
  use CoreWeb, :controller

  alias Core.Repo
  alias Core.AccountManager
  alias Core.AccountManager.User

  action_fallback CoreWeb.FallbackController

  plug :scrub_params, "user" when action in [:create]

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- AccountManager.create_user(user_params) do
      {:ok, jwt, _full_claims} = user |> Guardian.encode_and_sign(:token)
      {:ok, updated_user} = user |> AccountManager.grant_role

      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render(CoreWeb.SessionView, "show.json", jwt: jwt, user: updated_user |> Repo.preload([:role]))
    end
  end
end
