defmodule Core.LocationManagerTest do
  use Core.DataCase

  alias Core.LocationManager
  alias Core.LocationManager.LocationType

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  def fixture(:location_type, attrs \\ @create_attrs) do
    {:ok, location_type} = LocationManager.create_location_type(attrs)
    location_type
  end

  test "list_location_type/1 returns all location_type" do
    location_type = fixture(:location_type)
    assert LocationManager.list_location_type() == [location_type]
  end

  test "get_location_type! returns the location_type with given id" do
    location_type = fixture(:location_type)
    assert LocationManager.get_location_type!(location_type.id) == location_type
  end

  test "create_location_type/1 with valid data creates a location_type" do
    assert {:ok, %LocationType{} = location_type} = LocationManager.create_location_type(@create_attrs)
    assert location_type.description == "some description"
    assert location_type.name == "some name"
  end

  test "create_location_type/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = LocationManager.create_location_type(@invalid_attrs)
  end

  test "update_location_type/2 with valid data updates the location_type" do
    location_type = fixture(:location_type)
    assert {:ok, location_type} = LocationManager.update_location_type(location_type, @update_attrs)
    assert %LocationType{} = location_type
    assert location_type.description == "some updated description"
    assert location_type.name == "some updated name"
  end

  test "update_location_type/2 with invalid data returns error changeset" do
    location_type = fixture(:location_type)
    assert {:error, %Ecto.Changeset{}} = LocationManager.update_location_type(location_type, @invalid_attrs)
    assert location_type == LocationManager.get_location_type!(location_type.id)
  end

  test "delete_location_type/1 deletes the location_type" do
    location_type = fixture(:location_type)
    assert {:ok, %LocationType{}} = LocationManager.delete_location_type(location_type)
    assert_raise Ecto.NoResultsError, fn -> LocationManager.get_location_type!(location_type.id) end
  end

  test "change_location_type/1 returns a location_type changeset" do
    location_type = fixture(:location_type)
    assert %Ecto.Changeset{} = LocationManager.change_location_type(location_type)
  end
end
