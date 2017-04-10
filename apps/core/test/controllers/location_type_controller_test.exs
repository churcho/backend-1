defmodule Core.Web.LocationTypeControllerTest do
  @moduledoc """
  Location Type Controller
  """
  use Core.Web.ConnCase

  alias Core.LocationManager
  alias Core.LocationManager.LocationType

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  def fixture(:location_type) do
    {:ok, location_type} = LocationManager.create_location_type(@create_attrs)
    location_type
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, location_type_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates location_type and renders location_type when data is valid", %{conn: conn} do
    conn = post conn, location_type_path(conn, :create), location_type: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, location_type_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "description" => "some description",
      "name" => "some name"}
  end

  test "does not create location_type and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, location_type_path(conn, :create), location_type: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen location_type and renders location_type when data is valid", %{conn: conn} do
    %LocationType{id: id} = location_type = fixture(:location_type)
    conn = put conn, location_type_path(conn, :update, location_type), location_type: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, location_type_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "description" => "some updated description",
      "name" => "some updated name"}
  end

  test "does not update chosen location_type and renders errors when data is invalid", %{conn: conn} do
    location_type = fixture(:location_type)
    conn = put conn, location_type_path(conn, :update, location_type), location_type: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen location_type", %{conn: conn} do
    location_type = fixture(:location_type)
    conn = delete conn, location_type_path(conn, :delete, location_type)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, location_type_path(conn, :show, location_type)
    end
  end
end
