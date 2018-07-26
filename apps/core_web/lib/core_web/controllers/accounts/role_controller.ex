defmodule CoreWeb.RoleController do
  use CoreWeb, :controller
  alias Core.Accounts

  def index(conn, _params) do
    roles = Accounts.list_roles()
    render(conn, "index.json", roles: roles)
  end

  def create(conn, %{"role" => role_params}) do
    with {:ok, %role{} = role} <- Accounts.create_role(role_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("role", role_path(conn, :show, role))
      |> render("show.json", role: role)
    end
  end

  def show(conn, %{"id" => id}) do
    role = Accounts.get_role!(id)
    render(conn, "show.json", role: role)
  end
end
