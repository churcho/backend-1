defmodule Core.Web.ActionController do
  use Core.Web, :controller

  alias Core.ActionManager
  alias Core.ActionManager.Action

  action_fallback Core.Web.FallbackController

  def index(conn, _params) do
    actions = ActionManager.list_actions()
    render(conn, "index.json", actions: actions)
  end

  def create(conn, %{"action" => action_params}) do
    with {:ok, %Action{} = action} <- ActionManager.create_action(action_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", action_path(conn, :show, action))
      |> render("show.json", action: action)
    end
  end

  def show(conn, %{"id" => id}) do
    action = ActionManager.get_action!(id)
    render(conn, "show.json", action: action)
  end

  def update(conn, %{"id" => id, "action" => action_params}) do
    action = ActionManager.get_action!(id)

    with {:ok, %Action{} = action} <- ActionManager.update_action(action, action_params) do
      render(conn, "show.json", action: action)
    end
  end

  def delete(conn, %{"id" => id}) do
    action = ActionManager.get_action!(id)
    with {:ok, %Action{}} <- ActionManager.delete_action(action) do
      send_resp(conn, :no_content, "")
    end
  end
end
