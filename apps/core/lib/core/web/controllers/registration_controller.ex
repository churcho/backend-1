defmodule Core.Web.RegistrationController  do
  use Core.Web, :controller

  alias Core.Repo
  alias Core.AccountManager
  alias Core.AccountManager.User

  action_fallback Core.Web.FallbackController

  plug :scrub_params, "user" when action in [:create]

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- AccountManager.create_user(user_params) do
      {:ok, jwt, _full_claims} = user |> Guardian.encode_and_sign(:token)
      {:ok, updated_user} = user |> AccountManager.grant_role

      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render(Core.Web.SessionView, "show.json", jwt: jwt, user: updated_user |> Repo.preload([:role]))
    end
  end
end
