defmodule CoreWeb.EntityPropertyTypeController do
  use CoreWeb, :controller

  alias Core.EntityManager
  alias Core.EntityManager.PropertyType

  action_fallback(CoreWeb.FallbackController)

  def index(conn, _params) do
    property_types = EntityManager.list_property_types()
    render(conn, "index.json", property_types: property_types)
  end

  def create(conn, %{"property_type" => property_type_params}) do
    with {:ok, %PropertyType{} = property_type} <-
           EntityManager.create_property_type(property_type_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", entity_property_type_path(conn, :show, property_type))
      |> render("show.json", property_type: property_type)
    end
  end

  def show(conn, %{"id" => id}) do
    property_type = EntityManager.get_property_type!(id)
    render(conn, "show.json", property_type: property_type)
  end

  def update(conn, %{"id" => id, "property_type" => property_type_params}) do
    property_type = EntityManager.get_property_type!(id)

    with {:ok, %PropertyType{} = property_type} <-
           EntityManager.update_property_type(property_type, property_type_params) do
      render(conn, "show.json", property_type: property_type)
    end
  end

  def delete(conn, %{"id" => id}) do
    property_type = EntityManager.get_property_type!(id)

    with {:ok, %PropertyType{}} <- EntityManager.delete_property_type(property_type) do
      send_resp(conn, :no_content, "")
    end
  end
end
