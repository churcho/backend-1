defmodule Iotapi.ServiceTest do
  use Iotapi.ModelCase

  alias Iotapi.Service

  @valid_attrs %{access_token: "some content", bridge: true, client_id: "some content", client_secret: "some content", enabled: true, name: "some content", oauth: true, search_path: "some content", service_state: %{}, type: "some content", url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Service.changeset(%Service{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Service.changeset(%Service{}, @invalid_attrs)
    refute changeset.valid?
  end
end
