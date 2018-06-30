defmodule CoreWeb.CurrentUserController do
  @moduledoc """
  Current User Controller
  """
  use CoreWeb, :controller
  plug Guardian.Plug.EnsureAuthenticated, handler: CoreWeb.SessionController

  alias Guardian.Plug

  def show(conn, _) do

    user =
    conn
    |> Plug.current_resource()

    conn
    |> put_status(:ok)
    |> render("show.json", user: user)
  end
end
