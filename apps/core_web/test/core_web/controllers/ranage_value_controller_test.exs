defmodule CoreWeb.RanageValueControllerTest do
  use CoreWeb.ConnCase

  alias Core.PropertyManager
  alias Core.PropertyManager.RanageValue

  @create_attrs %{max: 42, min: 42}
  @update_attrs %{max: 43, min: 43}
  @invalid_attrs %{max: nil, min: nil}

  def fixture(:ranage_value) do
    {:ok, ranage_value} = PropertyManager.create_ranage_value(@create_attrs)
    ranage_value
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all range_values", %{conn: conn} do
      conn = get conn, ranage_value_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create ranage_value" do
    test "renders ranage_value when data is valid", %{conn: conn} do
      conn = post conn, ranage_value_path(conn, :create), ranage_value: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, ranage_value_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "max" => 42,
        "min" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, ranage_value_path(conn, :create), ranage_value: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update ranage_value" do
    setup [:create_ranage_value]

    test "renders ranage_value when data is valid", %{conn: conn, ranage_value: %RanageValue{id: id} = ranage_value} do
      conn = put conn, ranage_value_path(conn, :update, ranage_value), ranage_value: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, ranage_value_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "max" => 43,
        "min" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, ranage_value: ranage_value} do
      conn = put conn, ranage_value_path(conn, :update, ranage_value), ranage_value: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete ranage_value" do
    setup [:create_ranage_value]

    test "deletes chosen ranage_value", %{conn: conn, ranage_value: ranage_value} do
      conn = delete conn, ranage_value_path(conn, :delete, ranage_value)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, ranage_value_path(conn, :show, ranage_value)
      end
    end
  end

  defp create_ranage_value(_) do
    ranage_value = fixture(:ranage_value)
    {:ok, ranage_value: ranage_value}
  end
end
