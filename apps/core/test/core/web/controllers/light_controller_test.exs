defmodule Core.Web.LightControllerTest do
  use Core.Web.ConnCase

  alias Core.ConnectionManager
  alias Core.ConnectionManager.Light

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:light) do
    {:ok, light} = ConnectionManager.create_light(@create_attrs)
    light
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all lights", %{conn: conn} do
      conn = get conn, light_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create light" do
    test "renders light when data is valid", %{conn: conn} do
      conn = post conn, light_path(conn, :create), light: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, light_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, light_path(conn, :create), light: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update light" do
    setup [:create_light]

    test "renders light when data is valid", %{conn: conn, light: %Light{id: id} = light} do
      conn = put conn, light_path(conn, :update, light), light: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, light_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn, light: light} do
      conn = put conn, light_path(conn, :update, light), light: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete light" do
    setup [:create_light]

    test "deletes chosen light", %{conn: conn, light: light} do
      conn = delete conn, light_path(conn, :delete, light)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, light_path(conn, :show, light)
      end
    end
  end

  defp create_light(_) do
    light = fixture(:light)
    {:ok, light: light}
  end
end
