defmodule CoreWeb.EntityTypeController do
  use CoreWeb, :controller

  alias Core.EntityManager
  alias Core.EntityManager.EntityType

  action_fallback CoreWeb.FallbackController

  def index(conn, _params) do
    entity_types = EntityManager.list_entity_types()
    render(conn, "index.json", entity_types: entity_types)
  end

  def create(conn, %{"entity_type" => entity_type_params}) do
    with {:ok, %EntityType{} = entity_type} <- EntityManager.create_entity_type(entity_type_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", entity_type_path(conn, :show, entity_type))
      |> render("show.json", entity_type: entity_type)
    end
  end

  def show(conn, %{"id" => id}) do
    entity_type = EntityManager.get_entity_type!(id)
    render(conn, "show.json", entity_type: entity_type)
  end

  def update(conn, %{"id" => id, "entity_type" => entity_type_params}) do
    entity_type = EntityManager.get_entity_type!(id)

    with {:ok, %EntityType{} = entity_type} <- EntityManager.update_entity_type(entity_type, entity_type_params) do
      render(conn, "show.json", entity_type: entity_type)
    end
  end

  def delete(conn, %{"id" => id}) do
    entity_type = EntityManager.get_entity_type!(id)
    with {:ok, %EntityType{}} <- EntityManager.delete_entity_type(entity_type) do
      send_resp(conn, :no_content, "")
    end
  end
end
