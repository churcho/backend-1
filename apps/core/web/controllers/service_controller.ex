defmodule Core.ServiceController do
  use Core.Web, :controller

  alias Core.Service

  def index(conn, _params) do
    services = Repo.all(Service)
    |> Repo.preload([:provider, :entities])
    

    render(conn, "index.json", services: services)
  end

  def create(conn, %{"service" => service_params}) do
    changeset = Service.changeset(%Service{}, service_params)

    case Repo.insert(changeset) do
      {:ok, service} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", service_path(conn, :show, service))
        |> render("show.json", service: service |> Repo.preload([:provider, :entities]))
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Core.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    service = Repo.get!(Service, id)
    |> Repo.preload([:provider, :entities])

    render(conn, "show.json", service: service)
  end

  def update(conn, %{"id" => id, "service" => service_params}) do
    service = Repo.get!(Service, id)
    changeset = Service.changeset(service, service_params)

    case Repo.update(changeset) do
      {:ok, service} ->
        render(conn, "show.json", service: service |> Repo.preload([:provider, :entities]))
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Core.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    service = Repo.get!(Service, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(service)

    send_resp(conn, :no_content, "")
  end
end
