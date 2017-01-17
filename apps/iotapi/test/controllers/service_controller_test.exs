defmodule Iotapi.ServiceControllerTest do
  use Iotapi.ConnCase

  alias Iotapi.Service
  @valid_attrs %{access_token: "some content", bridge: true, client_id: "some content", client_secret: "some content", enabled: true, name: "some content", oauth: true, search_path: "some content", service_state: %{}, type: "some content", url: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, service_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    service = Repo.insert! %Service{}
    conn = get conn, service_path(conn, :show, service)
    assert json_response(conn, 200)["data"] == %{"id" => service.id,
      "name" => service.name,
      "client_id" => service.client_id,
      "client_secret" => service.client_secret,
      "access_token" => service.access_token,
      "url" => service.url,
      "oauth" => service.oauth,
      "bridge" => service.bridge,
      "enabled" => service.enabled,
      "type" => service.type,
      "search_path" => service.search_path,
      "service_state" => service.service_state}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, service_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, service_path(conn, :create), service: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Service, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, service_path(conn, :create), service: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    service = Repo.insert! %Service{}
    conn = put conn, service_path(conn, :update, service), service: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Service, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    service = Repo.insert! %Service{}
    conn = put conn, service_path(conn, :update, service), service: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    service = Repo.insert! %Service{}
    conn = delete conn, service_path(conn, :delete, service)
    assert response(conn, 204)
    refute Repo.get(Service, service.id)
  end
end
