defmodule CoreWeb.LocationController do
  use CoreWeb, :controller

  alias Core.LocationManager
  alias Core.LocationManager.Location
  alias Core.Repo

  action_fallback CoreWeb.FallbackController

  def index(conn, _params) do
    locations = LocationManager.list_locations()
    render(conn, "index.json", locations: locations)
  end

  def create(conn, %{"location" => location_params}) do
    with {:ok, %Location{} = location} <- LocationManager.create_location(location_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", location_path(conn, :show, location))
      |> render("show.json", location: location |> Repo.preload([:zones]))
    end
  end


  def show(conn, %{"id" => id}) do
    location = LocationManager.get_location!(id)
    render(conn, "show.json", location: location)
  end

  def update(conn, %{"id" => id, "location" => location_params}) do
    location = LocationManager.get_location!(id)

    with {:ok, %Location{} = location} <- LocationManager.update_location(location, location_params) do
      render(conn, "show.json", location: location |> Repo.preload([:zones]))
    end
  end

  def delete(conn, %{"id" => id}) do
    location = LocationManager.get_location!(id)
    with {:ok, %Location{}} <- LocationManager.delete_location(location) do
      send_resp(conn, :no_content, "")
    end
  end
end
