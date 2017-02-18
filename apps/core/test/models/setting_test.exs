defmodule Iotapi.SettingTest do
  use Iotapi.ModelCase

  alias Iotapi.Setting

  @valid_attrs %{description: "some content", environment: "some content", name: "some content", value: %{}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Setting.changeset(%Setting{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Setting.changeset(%Setting{}, @invalid_attrs)
    refute changeset.valid?
  end
end
