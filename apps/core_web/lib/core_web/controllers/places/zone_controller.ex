defmodule CoreWeb.ZoneController do
  @moduledoc false
  use CoreWeb, :controller

  alias Core.Places
  alias Core.Places.Zone

  def index(conn, _params) do
    zones = Places.list_zones()
    render(conn, "index.json", zones: zones)
  end

  def show(conn, %{"id" => id}) do
    zone = Places.get_zone!(id)
    render(conn, "show.json", zone: zone)
  end

  def delete(conn, %{"id" => id}) do
    zone = Places.get_zone!(id)

    with :ok <- Places.delete_zone(zone) do
      send_resp(conn, :no_content, "")
    end
  end

  def create(conn, %{"zone" => zone_params}) do
    with {:ok, %Zone{} = zone} <-
      Places.create_zone(zone_params)
    do
      conn
      |> put_status(:created)
      |> render("show.json", zone: zone)
    end
  end

  def update(conn, %{"id" => zone_id, "zone" => zone_params}) do

    zone = Places.get_zone!(zone_id)

    with {:ok, %Zone{} = zone} <-
      Places.update_zone(zone, zone_params)
    do
      conn
      |> put_status(:ok)
      |> render("show.json", zone: zone)
    end
  end
end
