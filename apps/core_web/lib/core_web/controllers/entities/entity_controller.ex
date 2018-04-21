defmodule CoreWeb.EntityController do
  use CoreWeb, :controller

  alias Core.EntityManager
  alias Core.EntityManager.Entity
  alias Core.Repo

  def index(conn, _params) do
    entities = EntityManager.list_entities()
    render(conn, "index.json", entities: entities)
  end

  def create(conn, %{"entity" => entity_params}) do
    with {:ok, %Entity{} = entity} <- EntityManager.create_entity(entity_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("entity", entity_path(conn, :show, entity))
      |> render(
        "show.json",
        entity:
          entity
          |> Repo.preload([
            :service,
            :entity_type,
            :property_types,
            :entity_properties,
            :action_types,
            :entity_actions
          ])
      )
    end
  end

  def show(conn, %{"id" => id}) do
    entity = EntityManager.get_entity!(id)
    render(conn, "show.json", entity: entity)
  end

  def update(conn, %{"id" => id, "entity" => entity_params}) do
    entity = EntityManager.get_entity!(id)

    with {:ok, %Entity{} = entity} <- EntityManager.update_entity(entity, entity_params) do
      render(conn, "show.json", entity: entity)
    end
  end

  def update_state(conn, entity_params) do
    entity = EntityManager.get_entity_by_uuid(entity_params["uuid"])

    with {:ok, %Entity{} = entity} <- EntityManager.update_entity_state(entity, entity_params) do
      render(conn, "show.json", entity: entity)
    end
  end

  def delete(conn, %{"id" => id}) do
    entity = EntityManager.get_entity!(id)

    with {:ok, %Entity{}} <- EntityManager.delete_entity(entity) do
      send_resp(conn, :no_content, "")
    end
  end

  def get_entity_properties(conn, %{"entity_id" => id}) do
    entity = EntityManager.get_entity!(id)
    render(conn, "properties_index.json", entity: entity)
  end

  def get_entity_actions(conn, %{"entity_id" => id}) do
    entity = EntityManager.get_entity!(id)
    render(conn, "actions_index.json", entity: entity)
  end

  def get_entity_events(conn, %{"entity_id" => id}) do
    entity = EntityManager.get_entity!(id)
    render(conn, "events_index.json", entity: entity)
  end

  def show_entity_property(conn, %{"entity_id" => entity_id, "property_id" => property_id}) do
    entity = EntityManager.get_entity!(entity_id)
    property = EntityManager.get_entity_property_state(entity, property_id)
    render(conn, "show_entity_property.json", entity: entity, property: property)
  end

  def set_entity_property(conn, %{
        "entity_id" => entity_id,
        "property_id" => property_id,
        "value" => value
      }) do
    entity = EntityManager.get_entity!(entity_id)
    {:ok, property} = EntityManager.set_entity_property_state(entity, property_id, value)
    render(conn, "show_entity_property.json", entity: entity, property: property.state)
  end
end
