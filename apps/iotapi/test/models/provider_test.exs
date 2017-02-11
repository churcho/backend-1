defmodule Iotapi.ProviderTest do
  use Iotapi.ModelCase

  alias Iotapi.Provider

  @valid_attrs %{callback_uri: "some content", name: "some content", uri: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Provider.changeset(%Provider{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Provider.changeset(%Provider{}, @invalid_attrs)
    refute changeset.valid?
  end
end
