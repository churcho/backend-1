defmodule Iotapi.LocationTest do
  use Iotapi.ModelCase

  alias Iotapi.Location

  @valid_attrs %{address_one: "some content", address_two: "some content", city: "some content", latitude: "some content", longitude: "some content", name: "some content", state: "some content", zip: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Location.changeset(%Location{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Location.changeset(%Location{}, @invalid_attrs)
    refute changeset.valid?
  end
end
