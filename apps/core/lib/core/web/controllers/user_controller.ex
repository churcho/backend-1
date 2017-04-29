defmodule Core.Web.UserController do
  use Core.Web, :controller

  alias Core.AccountManager

  def index(conn, _params) do
    users = Core.AccountManager.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %user{} = user} <- AccountManager.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("user", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = AccountManager.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = AccountManager.get_user!(id)

    with {:ok, %user{} = user} <- AccountManager.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = AccountManager.get_user!(id)
    with {:ok, %user{}} <- AccountManager.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
