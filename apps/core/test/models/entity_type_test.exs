defmodule Core.EntityTypeTest do
  use Core.ModelCase

  alias Core.EntityType

  @valid_attrs %{description: "some description", name: "some name"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = EntityType.changeset(%EntityType{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = EntityType.changeset(%EntityType{}, @invalid_attrs)
    refute changeset.valid?
  end
end
