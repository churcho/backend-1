defmodule Iotapi.ZoneControllerTest do
  use Iotapi.ConnCase

  alias Iotapi.Zone
  @valid_attrs %{description: "some content", name: "some content", state: %{}}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, zone_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    zone = Repo.insert! %Zone{}
    conn = get conn, zone_path(conn, :show, zone)
    assert json_response(conn, 200)["data"] == %{"id" => zone.id,
      "name" => zone.name,
      "description" => zone.description,
      "location_id" => zone.location_id,
      "state" => zone.state}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, zone_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, zone_path(conn, :create), zone: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Zone, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, zone_path(conn, :create), zone: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    zone = Repo.insert! %Zone{}
    conn = put conn, zone_path(conn, :update, zone), zone: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Zone, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    zone = Repo.insert! %Zone{}
    conn = put conn, zone_path(conn, :update, zone), zone: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    zone = Repo.insert! %Zone{}
    conn = delete conn, zone_path(conn, :delete, zone)
    assert response(conn, 204)
    refute Repo.get(Zone, zone.id)
  end
end
