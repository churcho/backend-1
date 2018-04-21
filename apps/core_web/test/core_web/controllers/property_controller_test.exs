defmodule CoreWeb.PropertyControllerTest do
  use CoreWeb.ConnCase

  alias Core.PropertyManager
  alias Core.PropertyManager.Property

  @create_attrs %{description: "some description", name: "some name", type: "some type", unit: "some unit"}
  @update_attrs %{description: "some updated description", name: "some updated name", type: "some updated type", unit: "some updated unit"}
  @invalid_attrs %{description: nil, name: nil, type: nil, unit: nil}

  def fixture(:property) do
    {:ok, property} = PropertyManager.create_property(@create_attrs)
    property
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all properties", %{conn: conn} do
      conn = get conn, property_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create property" do
    test "renders property when data is valid", %{conn: conn} do
      conn = post conn, property_path(conn, :create), property: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, property_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some description",
        "name" => "some name",
        "type" => "some type",
        "unit" => "some unit"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, property_path(conn, :create), property: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update property" do
    setup [:create_property]

    test "renders property when data is valid", %{conn: conn, property: %Property{id: id} = property} do
      conn = put conn, property_path(conn, :update, property), property: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, property_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some updated description",
        "name" => "some updated name",
        "type" => "some updated type",
        "unit" => "some updated unit"}
    end

    test "renders errors when data is invalid", %{conn: conn, property: property} do
      conn = put conn, property_path(conn, :update, property), property: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete property" do
    setup [:create_property]

    test "deletes chosen property", %{conn: conn, property: property} do
      conn = delete conn, property_path(conn, :delete, property)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, property_path(conn, :show, property)
      end
    end
  end

  defp create_property(_) do
    property = fixture(:property)
    {:ok, property: property}
  end
end
