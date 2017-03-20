
defmodule Core.RegistrationController  do
  use Core.Web, :controller

  alias Core.{Repo, User}

  plug :scrub_params, "user" when action in [:create]

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        {:ok, jwt, _full_claims} = user |> Guardian.encode_and_sign(:token)
        user 
        |> Core.RoleManager.grant_role



        conn
        |> put_status(:created)
        |> render(Core.SessionView, "show.json", jwt: jwt, user: user)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json", changeset: changeset)
    end
  end
end
