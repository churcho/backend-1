defmodule CoreWeb.UnitController do
  use CoreWeb, :controller

  alias Core.PropertyManager
  alias Core.PropertyManager.Unit

  action_fallback CoreWeb.FallbackController

  def index(conn, _params) do
    units = PropertyManager.list_units()
    render(conn, "index.json", units: units)
  end

  def create(conn, %{"unit" => unit_params}) do
    with {:ok, %Unit{} = unit} <- PropertyManager.create_unit(unit_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", property_unit_path(conn, :show, unit))
      |> render("show.json", unit: unit)
    end
  end

  def show(conn, %{"id" => id}) do
    unit = PropertyManager.get_unit!(id)
    render(conn, "show.json", unit: unit)
  end

  def update(conn, %{"id" => id, "unit" => unit_params}) do
    unit = PropertyManager.get_unit!(id)

    with {:ok, %Unit{} = unit} <- PropertyManager.update_unit(unit, unit_params) do
      render(conn, "show.json", unit: unit)
    end
  end

  def delete(conn, %{"id" => id}) do
    unit = PropertyManager.get_unit!(id)
    with {:ok, %Unit{}} <- PropertyManager.delete_unit(unit) do
      send_resp(conn, :no_content, "")
    end
  end
end
