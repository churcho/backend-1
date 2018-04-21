defmodule CoreWeb.RangeValueController do
  use CoreWeb, :controller

  alias Core.PropertyManager
  alias Core.PropertyManager.RangeValue

  action_fallback CoreWeb.FallbackController

  def index(conn, _params) do
    range_values = PropertyManager.list_range_values()
    render(conn, "index.json", range_values: range_values)
  end

  def create(conn, %{"range_value" => range_value_params}) do
    with {:ok, %RangeValue{} = range_value} <- PropertyManager.create_range_value(range_value_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", property_range_value_path(conn, :show, range_value))
      |> render("show.json", range_value: range_value)
    end
  end

  def show(conn, %{"id" => id}) do
    range_value = PropertyManager.get_range_value!(id)
    render(conn, "show.json", range_value: range_value)
  end

  def update(conn, %{"id" => id, "range_value" => range_value_params}) do
    range_value = PropertyManager.get_range_value!(id)

    with {:ok, %RangeValue{} = range_value} <- PropertyManager.update_range_value(range_value, range_value_params) do
      render(conn, "show.json", range_value: range_value)
    end
  end

  def delete(conn, %{"id" => id}) do
    range_value = PropertyManager.get_range_value!(id)
    with {:ok, %RangeValue{}} <- PropertyManager.delete_range_value(range_value) do
      send_resp(conn, :no_content, "")
    end
  end
end
