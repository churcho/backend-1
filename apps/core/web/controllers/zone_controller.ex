defmodule Core.ZoneController do
  use Core.Web, :controller

  alias Core.Zone

  def index(conn, _params) do
    zones = Repo.all(Zone)
    render(conn, "index.json", zones: zones)
  end

  def create(conn, %{"zone" => zone_params}) do
    changeset = Zone.changeset(%Zone{}, zone_params)

    case Repo.insert(changeset) do
      {:ok, zone} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", zone_path(conn, :show, zone))
        |> render("show.json", zone: zone)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Core.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    zone = Repo.get!(Zone, id)
    render(conn, "show.json", zone: zone)
  end

  def update(conn, %{"id" => id, "zone" => zone_params}) do
    zone = Repo.get!(Zone, id)
    changeset = Zone.changeset(zone, zone_params)

    case Repo.update(changeset) do
      {:ok, zone} ->
        render(conn, "show.json", zone: zone)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Core.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    zone = Repo.get!(Zone, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(zone)

    send_resp(conn, :no_content, "")
  end
end
