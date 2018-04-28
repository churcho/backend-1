defmodule CoreWeb.BooleanBooleanPropertyController do
  use CoreWeb, :controller

  alias Core.PropertyManager
  alias Core.PropertyManager.BooleanProperty

  action_fallback CoreWeb.FallbackController

  def index(conn, _params) do
    properties = PropertyManager.list_properties()
    render(conn, "index.json", properties: properties)
  end

  def create(conn, %{"boolean_property" => boolean_property_params}) do
    with {:ok, %BooleanProperty{} = boolean_property} <- PropertyManager.create_boolean_property(boolean_property_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", boolean_property_path(conn, :show, boolean_property))
      |> render("show.json", boolean_property: boolean_property)
    end
  end

  def show(conn, %{"id" => id}) do
    boolean_property = PropertyManager.get_boolean_property!(id)
    render(conn, "show.json", boolean_property: boolean_property)
  end

  def update(conn, %{"id" => id, "boolean_property" => boolean_property_params}) do
    boolean_property = PropertyManager.get_boolean_property!(id)

    with {:ok, %BooleanProperty{} = boolean_property} <- PropertyManager.update_boolean_property(boolean_property, boolean_property_params) do
      render(conn, "show.json", boolean_property: boolean_property)
    end
  end

  def delete(conn, %{"id" => id}) do
    boolean_property = PropertyManager.get_boolean_property!(id)
    with {:ok, %BooleanProperty{}} <- PropertyManager.delete_boolean_property(boolean_property) do
      send_resp(conn, :no_content, "")
    end
  end
end
