defmodule CoreWeb.CurrentUserController do
  @moduledoc """
  Current User Controller
  """
  use CoreWeb, :controller



  def show(conn, _params) do
    user =  Guardian.Plug.current_resource(conn)
    IO.inspect user
    conn
    |> put_status(:ok)
    |> render("show.json", user: user)
  end
end
