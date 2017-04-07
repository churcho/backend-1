defmodule Core.Web.EntityTypeControllerTest do
  use Core.Web.ConnCase

  alias Core.ServiceManager
  alias Core.ServiceManager.EntityType

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  def fixture(:entity_type) do
    {:ok, entity_type} = ServiceManager.create_entity_type(@create_attrs)
    entity_type
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, entity_type_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates entity_type and renders entity_type when data is valid", %{conn: conn} do
    conn = post conn, entity_type_path(conn, :create), entity_type: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, entity_type_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "description" => "some description",
      "name" => "some name"}
  end

  test "does not create entity_type and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, entity_type_path(conn, :create), entity_type: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen entity_type and renders entity_type when data is valid", %{conn: conn} do
    %EntityType{id: id} = entity_type = fixture(:entity_type)
    conn = put conn, entity_type_path(conn, :update, entity_type), entity_type: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, entity_type_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "description" => "some updated description",
      "name" => "some updated name"}
  end

  test "does not update chosen entity_type and renders errors when data is invalid", %{conn: conn} do
    entity_type = fixture(:entity_type)
    conn = put conn, entity_type_path(conn, :update, entity_type), entity_type: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen entity_type", %{conn: conn} do
    entity_type = fixture(:entity_type)
    conn = delete conn, entity_type_path(conn, :delete, entity_type)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, entity_type_path(conn, :show, entity_type)
    end
  end
end
