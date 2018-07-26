defmodule CoreWeb.LocationController do
  @moduledoc false
  use CoreWeb, :controller

  alias Core.Places
  alias Core.Places.Location

  def index(conn, _params) do
    locations = Places.list_locations()
    render(conn, "index.json", locations: locations)
  end

  def show(conn, %{"id" => id}) do
    location = Places.get_location!(id)
    render(conn, "show.json", location: location)
  end

  def delete(conn, %{"id" => id}) do
    location = Places.get_location!(id)

    with :ok <- Places.delete_location(location) do
      send_resp(conn, :no_content, "")
    end
  end

  def create(conn, %{"location" => location_params}) do
    with {:ok, %Location{} = location} <-
      Places.create_location(location_params)
    do
      conn
      |> put_status(:created)
      |> render("show.json", location: location)
    end
  end

  def update(conn, %{"id" => location_id, "location" => location_params}) do
    location = Places.get_location!(location_id)
    with {:ok, %Location{} = location} <-
      Places.update_location(location, location_params)
    do
      conn
      |> put_status(:ok)
      |> render("show.json", location: location)
    end
  end

end
