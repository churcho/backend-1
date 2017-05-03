defmodule Core.Web.ActionControllerTest do
  use Core.Web.ConnCase

  alias Core.ActionManager
  alias Core.ActionManager.Action

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:action) do
    {:ok, action} = ActionManager.create_action(@create_attrs)
    action
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, action_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates action and renders action when data is valid", %{conn: conn} do
    conn = post conn, action_path(conn, :create), action: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, action_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "name" => "some name"}
  end

  test "does not create action and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, action_path(conn, :create), action: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen action and renders action when data is valid", %{conn: conn} do
    %Action{id: id} = action = fixture(:action)
    conn = put conn, action_path(conn, :update, action), action: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, action_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "name" => "some updated name"}
  end

  test "does not update chosen action and renders errors when data is invalid", %{conn: conn} do
    action = fixture(:action)
    conn = put conn, action_path(conn, :update, action), action: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen action", %{conn: conn} do
    action = fixture(:action)
    conn = delete conn, action_path(conn, :delete, action)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, action_path(conn, :show, action)
    end
  end
end
