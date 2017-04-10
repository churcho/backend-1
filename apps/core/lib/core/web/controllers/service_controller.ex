defmodule Core.Web.ServiceController do
  use Core.Web, :controller

  alias Core.ServiceManager
  alias Core.ServiceManager.Service


  def index(conn, _params) do
    services = ServiceManager.list_services()
    render(conn, "index.json", services: services)
  end

  def create(conn, %{"service" => service_params}) do
    with {:ok, %Service{} = service} <- ServiceManager.create_service(service_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("service", service_path(conn, :show, service))
      |> render("show.json", service: service |> Core.Repo.preload([:provider, :entities]))
    end
  end


  def show(conn, %{"id" => id}) do
    service = ServiceManager.get_service!(id)
    render(conn, "show.json", service: service)
  end

  def update(conn, %{"id" => id, "service" => service_params}) do
    service = ServiceManager.get_service!(id)

    with {:ok, %Service{} = service} <- ServiceManager.update_service(service, service_params) do
      render(conn, "show.json", service: service |> Core.Repo.preload([:provider, :entities]))
    end
  end

  def delete(conn, %{"id" => id}) do
    service = ServiceManager.get_service!(id)
    with {:ok, %Service{}} <- ServiceManager.delete_service(service) do
      send_resp(conn, :no_content, "")
    end
  end
end
