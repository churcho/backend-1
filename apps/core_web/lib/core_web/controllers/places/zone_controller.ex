defmodule CoreWeb.ZoneController do
  @moduledoc false
  use CoreWeb, :controller

  alias Core.Places
  alias Core.Places.Projections.Zone

  def index(conn, _params) do
    zones = Places.list_zones()
    render(conn, "index.json", zones: zones)
  end

  def show(conn, %{"id" => uuid}) do
    zone = Places.zone_by_uuid(uuid)
    render(conn, "show.json", zone: zone)
  end

  def delete(conn, %{"id" => uuid}) do
    zone = Places.zone_by_uuid(uuid)

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

  def update(conn, %{"id" => zone_uuid, "zone" => zone_params}) do

    zone = Places.zone_by_uuid(zone_uuid)

    with {:ok, %Zone{} = zone} <-
      Places.update_zone(zone, zone_params)
    do
      conn
      |> put_status(:ok)
      |> render("show.json", zone: zone)
    end
  end
end
