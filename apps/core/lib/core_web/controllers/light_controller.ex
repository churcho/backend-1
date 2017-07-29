defmodule CoreWeb.LightController do
  use CoreWeb, :controller

  alias Core.ConnectionManager
  alias Core.ConnectionManager.Light

  action_fallback CoreWeb.FallbackController

  def index(conn, _params) do
    lights = ConnectionManager.list_lights()
    render(conn, "index.json", lights: lights)
  end

  def create(conn, %{"light" => light_params}) do
    with {:ok, %Light{} = light} <- ConnectionManager.create_light(light_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", room_light_path(conn, :show, light))
      |> render("show.json", light: light)
    end
  end

  def show(conn, %{"id" => id}) do
    light = ConnectionManager.get_light!(id)
    render(conn, "show.json", light: light)
  end

  def update(conn, %{"id" => id, "light" => light_params}) do
    light = ConnectionManager.get_light!(id)

    with {:ok, %Light{} = light} <- ConnectionManager.update_light(light, light_params) do
      render(conn, "show.json", light: light)
    end
  end

  def delete(conn, %{"id" => id}) do
    light = ConnectionManager.get_light!(id)
    with {:ok, %Light{}} <- ConnectionManager.delete_light(light) do
      send_resp(conn, :no_content, "")
    end
  end
end
