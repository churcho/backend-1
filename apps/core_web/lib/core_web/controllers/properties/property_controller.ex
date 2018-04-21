defmodule CoreWeb.PropertyController do
  use CoreWeb, :controller

  alias Core.PropertyManager
  alias Core.PropertyManager.Property

  action_fallback CoreWeb.FallbackController

  def index(conn, _params) do
    properties = PropertyManager.list_properties()
    render(conn, "index.json", properties: properties)
  end

  def create(conn, %{"property" => property_params}) do
    with {:ok, %Property{} = property} <- PropertyManager.create_property(property_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", property_path(conn, :show, property))
      |> render("show.json", property: property)
    end
  end

  def show(conn, %{"id" => id}) do
    property = PropertyManager.get_property!(id)
    render(conn, "show.json", property: property)
  end

  def update(conn, %{"id" => id, "property" => property_params}) do
    property = PropertyManager.get_property!(id)

    with {:ok, %Property{} = property} <- PropertyManager.update_property(property, property_params) do
      render(conn, "show.json", property: property)
    end
  end

  def delete(conn, %{"id" => id}) do
    property = PropertyManager.get_property!(id)
    with {:ok, %Property{}} <- PropertyManager.delete_property(property) do
      send_resp(conn, :no_content, "")
    end
  end
end
