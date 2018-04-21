defmodule CoreWeb.ZoneController do
  use CoreWeb, :controller

  alias Core.ZoneManager
  alias Core.ZoneManager.Zone

  action_fallback CoreWeb.FallbackController

  def index(conn, _params) do
    zones = ZoneManager.list_zones()
    render(conn, "index.json", zones: zones)
  end

  def create(conn, %{"zone" => zone_params}) do
    with {:ok, %Zone{} = zone} <- ZoneManager.create_zone(zone_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("zone", zone_path(conn, :show, zone))
      |> render("show.json", zone: zone |> Core.Repo.preload([:location, :rooms]))
    end
  end


  def show(conn, %{"id" => id}) do
    zone = ZoneManager.get_zone!(id)
    render(conn, "show.json", zone: zone)
  end

  def update(conn, %{"id" => id, "zone" => zone_params}) do
    zone = ZoneManager.get_zone!(id)

    with {:ok, %Zone{} = zone} <- ZoneManager.update_zone(zone, zone_params) do
      render(conn, "show.json", zone: zone |> Core.Repo.preload([:location, :rooms]))
    end
  end

  def delete(conn, %{"id" => id}) do
    zone = ZoneManager.get_zone!(id)
    with {:ok, %Zone{}} <- ZoneManager.delete_zone(zone) do
      send_resp(conn, :no_content, "")
    end
  end
end
