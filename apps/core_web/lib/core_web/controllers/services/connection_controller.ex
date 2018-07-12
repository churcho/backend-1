defmodule CoreWeb.ConnectionController do
  @moduledoc false
  use CoreWeb, :controller

  alias Core.Services
  alias Core.Services.Projections.Connection

  def index(conn, _params) do
    connections = Services.list_connections()
    render(conn, "index.json", connections: connections)
  end

  def show(conn, %{"id" => uuid}) do
    connection = Services.connection_by_uuid(uuid)
    render(conn, "show.json", connection: connection)
  end

  def create(conn, %{"service" => connection_params}) do
    with {:ok, %Connection{} = connection} <-
      Services.create_connection(connection_params)
    do
      conn
      |> put_status(:created)
      |> render("show.json", connection: connection)
    end
  end

  def delete(conn, %{"id" => uuid}) do
    connection = Services.connection_by_uuid(uuid)

    with :ok <- Services.delete_connection(connection) do
      send_resp(conn, :no_content, "")
    end
  end
end
