defmodule CoreWeb.EventTypeControllerTest do
  use CoreWeb.ConnCase

  alias Core.ServiceManager
  alias Core.ServiceManager.EventType

  @create_attrs %{description: "some description", name: "some name", payload: %{}}
  @update_attrs %{description: "some updated description", name: "some updated name", payload: %{}}
  @invalid_attrs %{description: nil, name: nil, payload: nil}

  def fixture(:event_type) do
    {:ok, event_type} = ServiceManager.create_event_type(@create_attrs)
    event_type
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all event_types", %{conn: conn} do
      conn = get conn, event_type_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create event_type" do
    test "renders event_type when data is valid", %{conn: conn} do
      conn = post conn, event_type_path(conn, :create), event_type: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, event_type_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some description",
        "name" => "some name",
        "payload" => %{}}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, event_type_path(conn, :create), event_type: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update event_type" do
    setup [:create_event_type]

    test "renders event_type when data is valid", %{conn: conn, event_type: %EventType{id: id} = event_type} do
      conn = put conn, event_type_path(conn, :update, event_type), event_type: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, event_type_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some updated description",
        "name" => "some updated name",
        "payload" => %{}}
    end

    test "renders errors when data is invalid", %{conn: conn, event_type: event_type} do
      conn = put conn, event_type_path(conn, :update, event_type), event_type: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete event_type" do
    setup [:create_event_type]

    test "deletes chosen event_type", %{conn: conn, event_type: event_type} do
      conn = delete conn, event_type_path(conn, :delete, event_type)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, event_type_path(conn, :show, event_type)
      end
    end
  end

  defp create_event_type(_) do
    event_type = fixture(:event_type)
    {:ok, event_type: event_type}
  end
end
