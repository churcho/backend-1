defmodule Core.Web.EntityControllerTest do
  use Core.Web.ConnCase

  alias Core.Lights
  alias Core.Lights.Entity

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  def fixture(:entity) do
    {:ok, entity} = Lights.create_entity(@create_attrs)
    entity
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, entity_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates entity and renders entity when data is valid", %{conn: conn} do
    conn = post conn, entity_path(conn, :create), entity: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, entity_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "description" => "some description",
      "name" => "some name"}
  end

  test "does not create entity and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, entity_path(conn, :create), entity: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen entity and renders entity when data is valid", %{conn: conn} do
    %Entity{id: id} = entity = fixture(:entity)
    conn = put conn, entity_path(conn, :update, entity), entity: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, entity_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "description" => "some updated description",
      "name" => "some updated name"}
  end

  test "does not update chosen entity and renders errors when data is invalid", %{conn: conn} do
    entity = fixture(:entity)
    conn = put conn, entity_path(conn, :update, entity), entity: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen entity", %{conn: conn} do
    entity = fixture(:entity)
    conn = delete conn, entity_path(conn, :delete, entity)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, entity_path(conn, :show, entity)
    end
  end
end
