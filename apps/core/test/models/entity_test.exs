defmodule Core.EntityTest do
  use Core.ModelCase

  alias Core.Entity

  @valid_attrs %{description: "some content", label: "some content", metadata: %{}, name: "some content", state: %{}, uuid: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Entity.changeset(%Entity{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Entity.changeset(%Entity{}, @invalid_attrs)
    refute changeset.valid?
  end
end
