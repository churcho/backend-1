defmodule Core.ProviderControllerTest do
  use Core.ConnCase

  alias Core.Provider
  @valid_attrs %{callback_uri: "some content", name: "some content", uri: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, provider_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    provider = Repo.insert! %Provider{}
    conn = get conn, provider_path(conn, :show, provider)
    assert json_response(conn, 200)["data"] == %{"id" => provider.id,
      "name" => provider.name,
      "uri" => provider.uri,
      "callback_uri" => provider.callback_uri}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, provider_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, provider_path(conn, :create), provider: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Provider, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, provider_path(conn, :create), provider: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    provider = Repo.insert! %Provider{}
    conn = put conn, provider_path(conn, :update, provider), provider: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Provider, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    provider = Repo.insert! %Provider{}
    conn = put conn, provider_path(conn, :update, provider), provider: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    provider = Repo.insert! %Provider{}
    conn = delete conn, provider_path(conn, :delete, provider)
    assert response(conn, 204)
    refute Repo.get(Provider, provider.id)
  end
end
