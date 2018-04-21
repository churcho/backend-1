defmodule CoreWeb.EntityActionTypeController do
  use CoreWeb, :controller

  alias Core.EntityManager
  alias Core.EntityManager.ActionType

  action_fallback CoreWeb.FallbackController

  def index(conn, _params) do
    action_types = EntityManager.list_action_types()
    render(conn, "index.json", action_types: action_types)
  end

  def create(conn, %{"action_type" => action_type_params}) do
    with {:ok, %ActionType{} = action_type} <- EntityManager.create_action_type(action_type_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", entity_action_type_path(conn, :show, action_type))
      |> render("show.json", action_type: action_type)
    end
  end

  def show(conn, %{"id" => id}) do
    action_type = EntityManager.get_action_type!(id)
    render(conn, "show.json", action_type: action_type)
  end

  def update(conn, %{"id" => id, "action_type" => action_type_params}) do
    action_type = EntityManager.get_action_type!(id)

    with {:ok, %ActionType{} = action_type} <- EntityManager.update_action_type(action_type, action_type_params) do
      render(conn, "show.json", action_type: action_type)
    end
  end

  def delete(conn, %{"id" => id}) do
    action_type = EntityManager.get_action_type!(id)
    with {:ok, %ActionType{}} <- EntityManager.delete_action_type(action_type) do
      send_resp(conn, :no_content, "")
    end
  end
end
