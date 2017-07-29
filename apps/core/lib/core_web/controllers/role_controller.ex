defmodule CoreWeb.RoleController do
  use CoreWeb, :controller

  alias Core.AccountManager

  def index(conn, _params) do
    roles = Core.AccountManager.list_roles()
    render(conn, "index.json", roles: roles)
  end

  def create(conn, %{"role" => role_params}) do
    with {:ok, %role{} = role} <- AccountManager.create_role(role_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("role", role_path(conn, :show, role))
      |> render("show.json", role: role)
    end
  end

  def show(conn, %{"id" => id}) do
    role = AccountManager.get_role!(id)
    render(conn, "show.json", role: role)
  end

  def update(conn, %{"id" => id, "role" => role_params}) do
    role = AccountManager.get_role!(id)

    with {:ok, %role{} = role} <- AccountManager.update_role(role, role_params) do
      render(conn, "show.json", role: role)
    end
  end

  def delete(conn, %{"id" => id}) do
    role = AccountManager.get_role!(id)
    with {:ok, %role{}} <- AccountManager.delete_role(role) do
      send_resp(conn, :no_content, "")
    end
  end
end
