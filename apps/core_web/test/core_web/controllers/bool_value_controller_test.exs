defmodule CoreWeb.BoolValueControllerTest do
  use CoreWeb.ConnCase

  alias Core.PropertyManager
  alias Core.PropertyManager.BoolValue

  @create_attrs %{values: []}
  @update_attrs %{values: []}
  @invalid_attrs %{values: nil}

  def fixture(:bool_value) do
    {:ok, bool_value} = PropertyManager.create_bool_value(@create_attrs)
    bool_value
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all bool_values", %{conn: conn} do
      conn = get conn, bool_value_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create bool_value" do
    test "renders bool_value when data is valid", %{conn: conn} do
      conn = post conn, bool_value_path(conn, :create), bool_value: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, bool_value_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "values" => []}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, bool_value_path(conn, :create), bool_value: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update bool_value" do
    setup [:create_bool_value]

    test "renders bool_value when data is valid", %{conn: conn, bool_value: %BoolValue{id: id} = bool_value} do
      conn = put conn, bool_value_path(conn, :update, bool_value), bool_value: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, bool_value_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "values" => []}
    end

    test "renders errors when data is invalid", %{conn: conn, bool_value: bool_value} do
      conn = put conn, bool_value_path(conn, :update, bool_value), bool_value: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete bool_value" do
    setup [:create_bool_value]

    test "deletes chosen bool_value", %{conn: conn, bool_value: bool_value} do
      conn = delete conn, bool_value_path(conn, :delete, bool_value)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, bool_value_path(conn, :show, bool_value)
      end
    end
  end

  defp create_bool_value(_) do
    bool_value = fixture(:bool_value)
    {:ok, bool_value: bool_value}
  end
end
