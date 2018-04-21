defmodule CoreWeb.BoolValueController do
  use CoreWeb, :controller

  alias Core.PropertyManager
  alias Core.PropertyManager.BoolValue

  action_fallback CoreWeb.FallbackController

  def index(conn, _params) do
    bool_values = PropertyManager.list_bool_values()
    render(conn, "index.json", bool_values: bool_values)
  end

  def create(conn, %{"bool_value" => bool_value_params}) do
    with {:ok, %BoolValue{} = bool_value} <- PropertyManager.create_bool_value(bool_value_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", property_bool_value_path(conn, :show, bool_value))
      |> render("show.json", bool_value: bool_value)
    end
  end

  def show(conn, %{"id" => id}) do
    bool_value = PropertyManager.get_bool_value!(id)
    render(conn, "show.json", bool_value: bool_value)
  end

  def update(conn, %{"id" => id, "bool_value" => bool_value_params}) do
    bool_value = PropertyManager.get_bool_value!(id)

    with {:ok, %BoolValue{} = bool_value} <- PropertyManager.update_bool_value(bool_value, bool_value_params) do
      render(conn, "show.json", bool_value: bool_value)
    end
  end

  def delete(conn, %{"id" => id}) do
    bool_value = PropertyManager.get_bool_value!(id)
    with {:ok, %BoolValue{}} <- PropertyManager.delete_bool_value(bool_value) do
      send_resp(conn, :no_content, "")
    end
  end
end
