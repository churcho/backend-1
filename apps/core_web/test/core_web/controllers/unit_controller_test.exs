defmodule CoreWeb.UnitControllerTest do
  use CoreWeb.ConnCase

  alias Core.PropertyManager
  alias Core.PropertyManager.Unit

  @create_attrs %{enum: [], name: "some name", value: "some value"}
  @update_attrs %{enum: [], name: "some updated name", value: "some updated value"}
  @invalid_attrs %{enum: nil, name: nil, value: nil}

  def fixture(:unit) do
    {:ok, unit} = PropertyManager.create_unit(@create_attrs)
    unit
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all units", %{conn: conn} do
      conn = get conn, unit_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create unit" do
    test "renders unit when data is valid", %{conn: conn} do
      conn = post conn, unit_path(conn, :create), unit: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, unit_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "enum" => [],
        "name" => "some name",
        "value" => "some value"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, unit_path(conn, :create), unit: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update unit" do
    setup [:create_unit]

    test "renders unit when data is valid", %{conn: conn, unit: %Unit{id: id} = unit} do
      conn = put conn, unit_path(conn, :update, unit), unit: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, unit_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "enum" => [],
        "name" => "some updated name",
        "value" => "some updated value"}
    end

    test "renders errors when data is invalid", %{conn: conn, unit: unit} do
      conn = put conn, unit_path(conn, :update, unit), unit: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete unit" do
    setup [:create_unit]

    test "deletes chosen unit", %{conn: conn, unit: unit} do
      conn = delete conn, unit_path(conn, :delete, unit)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, unit_path(conn, :show, unit)
      end
    end
  end

  defp create_unit(_) do
    unit = fixture(:unit)
    {:ok, unit: unit}
  end
end
