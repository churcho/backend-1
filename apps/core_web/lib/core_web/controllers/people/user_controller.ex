defmodule CoreWeb.UserController do
  use CoreWeb, :controller
  alias Core.People

  def index(conn, _params) do
    users = People.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %user{} = user} <- People.register_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("user", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => uuid}) do
    user = People.user_by_uuid(uuid)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => uuid, "user" => user_params}) do
    user = People.user_by_uuid(uuid)

    with {:ok, %user{} = user} <- People.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end
end
