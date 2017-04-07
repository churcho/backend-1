defmodule Core.Web.EntityTypeController do
  use Core.Web, :controller

  alias Core.ServiceManager
  alias Core.ServiceManager.EntityType

  action_fallback Core.Web.FallbackController

  def index(conn, _params) do
    entity_types = ServiceManager.list_entity_types()
    render(conn, "index.json", entity_types: entity_types)
  end

  def create(conn, %{"entity_type" => entity_type_params}) do
    with {:ok, %EntityType{} = entity_type} <- ServiceManager.create_entity_type(entity_type_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", entity_type_path(conn, :show, entity_type))
      |> render("show.json", entity_type: entity_type)
    end
  end

  def show(conn, %{"id" => id}) do
    entity_type = ServiceManager.get_entity_type!(id)
    render(conn, "show.json", entity_type: entity_type)
  end

  def update(conn, %{"id" => id, "entity_type" => entity_type_params}) do
    entity_type = ServiceManager.get_entity_type!(id)

    with {:ok, %EntityType{} = entity_type} <- ServiceManager.update_entity_type(entity_type, entity_type_params) do
      render(conn, "show.json", entity_type: entity_type)
    end
  end

  def delete(conn, %{"id" => id}) do
    entity_type = ServiceManager.get_entity_type!(id)
    with {:ok, %EntityType{}} <- ServiceManager.delete_entity_type(entity_type) do
      send_resp(conn, :no_content, "")
    end
  end
end
