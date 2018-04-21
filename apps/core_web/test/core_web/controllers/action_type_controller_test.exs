defmodule CoreWeb.ActionTypeControllerTest do
  use CoreWeb.ConnCase

  alias Core.ServiceManager
  alias Core.ServiceManager.ActionType

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  def fixture(:action_type) do
    {:ok, action_type} = ServiceManager.create_action_type(@create_attrs)
    action_type
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all action_types", %{conn: conn} do
      conn = get conn, action_type_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create action_type" do
    test "renders action_type when data is valid", %{conn: conn} do
      conn = post conn, action_type_path(conn, :create), action_type: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, action_type_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some description",
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, action_type_path(conn, :create), action_type: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update action_type" do
    setup [:create_action_type]

    test "renders action_type when data is valid", %{conn: conn, action_type: %ActionType{id: id} = action_type} do
      conn = put conn, action_type_path(conn, :update, action_type), action_type: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, action_type_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some updated description",
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, action_type: action_type} do
      conn = put conn, action_type_path(conn, :update, action_type), action_type: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete action_type" do
    setup [:create_action_type]

    test "deletes chosen action_type", %{conn: conn, action_type: action_type} do
      conn = delete conn, action_type_path(conn, :delete, action_type)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, action_type_path(conn, :show, action_type)
      end
    end
  end

  defp create_action_type(_) do
    action_type = fixture(:action_type)
    {:ok, action_type: action_type}
  end
end
