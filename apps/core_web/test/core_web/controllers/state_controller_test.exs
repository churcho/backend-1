defmodule CoreWeb.StateControllerTest do
  use CoreWeb.ConnCase

  alias Core.LocationManager
  alias Core.LocationManager.State

  @create_attrs %{indoor_temperautre: 120.5, outdoor_temperature: 120.5}
  @update_attrs %{indoor_temperautre: 456.7, outdoor_temperature: 456.7}
  @invalid_attrs %{indoor_temperautre: nil, outdoor_temperature: nil}

  def fixture(:state) do
    {:ok, state} = LocationManager.create_state(@create_attrs)
    state
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all states", %{conn: conn} do
      conn = get conn, state_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create state" do
    test "renders state when data is valid", %{conn: conn} do
      conn = post conn, state_path(conn, :create), state: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, state_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "indoor_temperautre" => 120.5,
        "outdoor_temperature" => 120.5}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, state_path(conn, :create), state: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update state" do
    setup [:create_state]

    test "renders state when data is valid", %{conn: conn, state: %State{id: id} = state} do
      conn = put conn, state_path(conn, :update, state), state: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, state_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "indoor_temperautre" => 456.7,
        "outdoor_temperature" => 456.7}
    end

    test "renders errors when data is invalid", %{conn: conn, state: state} do
      conn = put conn, state_path(conn, :update, state), state: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete state" do
    setup [:create_state]

    test "deletes chosen state", %{conn: conn, state: state} do
      conn = delete conn, state_path(conn, :delete, state)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, state_path(conn, :show, state)
      end
    end
  end

  defp create_state(_) do
    state = fixture(:state)
    {:ok, state: state}
  end
end
