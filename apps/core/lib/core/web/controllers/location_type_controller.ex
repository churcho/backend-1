defmodule Core.Web.LocationTypeController do
  use Core.Web, :controller

  alias Core.LocationManager
  alias Core.LocationManager.LocationType

  action_fallback Core.Web.FallbackController

  def index(conn, _params) do
    location_types = LocationManager.list_location_types()
    render(conn, "index.json", location_types: location_types)
  end

  def create(conn, %{"location_type" => location_type_params}) do
    with {:ok, %LocationType{} = location_type} <- LocationManager.create_location_type(location_type_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", location_type_path(conn, :show, location_type))
      |> render("show.json", location_type: location_type)
    end
  end

  def show(conn, %{"id" => id}) do
    location_type = LocationManager.get_location_type!(id)
    render(conn, "show.json", location_type: location_type)
  end

  def update(conn, %{"id" => id, "location_type" => location_type_params}) do
    location_type = LocationManager.get_location_type!(id)

    with {:ok, %LocationType{} = location_type} <- LocationManager.update_location_type(location_type, location_type_params) do
      render(conn, "show.json", location_type: location_type)
    end
  end

  def delete(conn, %{"id" => id}) do
    location_type = LocationManager.get_location_type!(id)
    with {:ok, %LocationType{}} <- LocationManager.delete_location_type(location_type) do
      send_resp(conn, :no_content, "")
    end
  end
end
