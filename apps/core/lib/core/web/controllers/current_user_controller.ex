defmodule Core.Web.CurrentUserController do
  @moduledoc """
  Current User Controller
  """
  use Core.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated, handler: Core.SessionController

  def show(conn, _) do

    user =
    conn
    |> Guardian.Plug.current_resource()
    |> Core.Repo.preload(:role)

    conn
    |> put_status(:ok)
    |> render("show.json", user: user)
  end
end
