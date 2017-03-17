defmodule Core.ZoneTest do
  use Core.ModelCase

  alias Core.Zone

  @valid_attrs %{description: "some content", name: "some content", state: %{}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Zone.changeset(%Zone{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Zone.changeset(%Zone{}, @invalid_attrs)
    refute changeset.valid?
  end
end
