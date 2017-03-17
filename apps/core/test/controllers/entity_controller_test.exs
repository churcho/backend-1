defmodule Core.EntityControllerTest do
  use Core.ConnCase

  alias Core.Entity
  @valid_attrs %{description: "some content", label: "some content", metadata: %{}, name: "some content", state: %{}, uuid: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, entity_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    entity = Repo.insert! %Entity{}
    conn = get conn, entity_path(conn, :show, entity)
    assert json_response(conn, 200)["data"] == %{"id" => entity.id,
      "name" => entity.name,
      "uuid" => entity.uuid,
      "description" => entity.description,
      "label" => entity.label,
      "metadata" => entity.metadata,
      "state" => entity.state}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, entity_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, entity_path(conn, :create), entity: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Entity, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, entity_path(conn, :create), entity: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    entity = Repo.insert! %Entity{}
    conn = put conn, entity_path(conn, :update, entity), entity: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Entity, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    entity = Repo.insert! %Entity{}
    conn = put conn, entity_path(conn, :update, entity), entity: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    entity = Repo.insert! %Entity{}
    conn = delete conn, entity_path(conn, :delete, entity)
    assert response(conn, 204)
    refute Repo.get(Entity, entity.id)
  end
end
