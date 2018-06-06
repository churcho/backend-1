defmodule CoreWeb.RoleController do
  use CoreWeb, :controller
  alias Core.People

  def index(conn, _params) do
    roles = People.list_roles()
    render(conn, "index.json", roles: roles)
  end

  def create(conn, %{"role" => role_params}) do
    with {:ok, %role{} = role} <- People.create_role(role_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("role", role_path(conn, :show, role))
      |> render("show.json", role: role)
    end
  end

  def show(conn, %{"id" => uuid}) do
    role = People.role_by_uuid(uuid)
    render(conn, "show.json", role: role)
  end
end
