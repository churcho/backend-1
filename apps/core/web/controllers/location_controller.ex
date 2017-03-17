defmodule Core.LocationController do
  use Core.Web, :controller

  alias Core.Location

  def index(conn, _params) do
    locations = Repo.all(Location)
    |> Repo.preload([:zones])
    render(conn, "index.json", locations: locations)
  end

  def create(conn, %{"location" => location_params}) do
    changeset = Location.changeset(%Location{}, location_params)

    case Repo.insert(changeset) do
      {:ok, location} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", location_path(conn, :show, location))
        |> render("created.json", location: location)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Core.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    location = Repo.get!(Location, id)
    |> Repo.preload([:zones])
    render(conn, "show.json", location: location)
  end

  def update(conn, %{"id" => id, "location" => location_params}) do
    location = Repo.get!(Location, id)
    changeset = Location.changeset(location, location_params)

    case Repo.update(changeset) do
      {:ok, location} ->
        render(conn, "show.json", location: location)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Core.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    location = Repo.get!(Location, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(location)

    send_resp(conn, :no_content, "")
  end
end
