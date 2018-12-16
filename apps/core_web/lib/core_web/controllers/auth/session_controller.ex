defmodule CoreWeb.SessionController do
  @moduledoc """
  Session Controller
  """
  use CoreWeb, :controller
  alias CoreWeb.Session
  alias CoreWeb.Guardian.Plug

  action_fallback CoreWeb.FallbackController
  plug :scrub_params, "session" when action in [:create]

  def create(conn, %{"session" => session_params}) do
    case Session.authenticate(session_params) do
      {:ok, user} ->
        {:ok, jwt, _full_claims} = user |> CoreWeb.Guardian.encode_and_sign

        conn
        |> put_status(:created)
        |> render("show.json", jwt: jwt, user: user)

        _ ->
          {:error, :unauthorized}
    end
  end

  def delete(conn, _) do
    conn
    |> Plug.current_token
    |> CoreWeb.Guardian.revoke

    conn
    |> render("delete.json")
  end

  def unauthenticated(conn, _params) do
    conn
    |> put_status(:forbidden)
    |> render(CoreWeb.SessionView, "forbidden.json", error: "Not Authenticated")
  end
end
