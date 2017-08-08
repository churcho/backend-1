defmodule CoreWeb.EntityController do
  use CoreWeb, :controller

  alias Core.ServiceManager
  alias Core.ServiceManager.Entity
  alias Core.Repo

  def index(conn, _params) do
    entities = ServiceManager.list_entities()
    render(conn, "index.json", entities: entities)
  end

  def create(conn, %{"entity" => entity_params}) do
    with {:ok, %Entity{} = entity} <- ServiceManager.create_entity(entity_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("entity", entity_path(conn, :show, entity))
      |> render("show.json", entity: entity)
    end
  end


  def show(conn, %{"id" => id}) do
    entity = ServiceManager.get_entity!(id)
    render(conn, "show.json", entity: entity)
  end

  def update(conn, %{"id" => id, "entity" => entity_params}) do
    entity = ServiceManager.get_entity!(id)

    with {:ok, %Entity{} = entity} <- ServiceManager.update_entity(entity, entity_params) do
      render(conn, "show.json", entity: entity)
    end
  end

  def update_state(conn, entity_params) do
    IO.puts "Time for a state update"
    IO.inspect entity_params
    entity = ServiceManager.get_entity_by_uuid(entity_params["uuid"])

    with {:ok, %Entity{} = entity} <- ServiceManager.update_entity_state(entity, entity_params) do
      render(conn, "show.json", entity: entity |> Repo.preload([:service]))
    end
  end

  def delete(conn, %{"id" => id}) do
    entity = ServiceManager.get_entity!(id)
    with {:ok, %Entity{}} <- ServiceManager.delete_entity(entity) do
      send_resp(conn, :no_content, "")
    end
  end
end
