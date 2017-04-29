defmodule Core.LocationManagerTest do
  @moduledoc false

  use Core.DataCase
  alias Core.Repo
  alias Core.LocationManager
  alias Core.LocationManager.Location
  alias Core.LocationManager.LocationType

  #generic fixtures
  @location_type_create_attrs %{description: "some description", name: "some name"}
  @location_type_update_attrs %{description: "some updated description", name: "some updated name"}
  @location_type_invalid_attrs %{description: nil, name: nil}

  # Fixtures for locations
  @location_create_attrs %{name: "some name", zone_id: 1}
  @location_update_attrs %{name: "some updated name", zone_id: 1}
  @location_invalid_attrs %{name: nil, zone_id: nil}

  def location_type_fixture(:location_type, attrs \\ @location_type_create_attrs) do
    {:ok, location_type} =
    attrs
    |> LocationManager.create_location_type()
    location_type
  end

  def location_fixture(:location, attrs \\ @location_create_attrs) do
    {:ok, location} = LocationManager.create_location(attrs)
    location
    |> Repo.preload([:zones])
  end

  test "list_location_types/1 returns all location_type" do
    location_type = location_type_fixture(:location_type)
    assert LocationManager.list_location_types() == [location_type]
  end

  test "list_locations/1 returns all locations" do
    location = location_fixture(:location)
    assert LocationManager.list_locations() == [location]
  end

  test "get_location_type! returns the location_type with given id" do
    location_type = location_type_fixture(:location_type)
    assert LocationManager.get_location_type!(location_type.id) == location_type
  end

  test "get_location! returns the location with given id" do
    location = location_fixture(:location)
    assert LocationManager.get_location!(location.id) == location
  end

  test "create_location_type/1 with valid data creates a location_type" do
    assert {:ok, %LocationType{} = location_type} = LocationManager.create_location_type(@location_type_create_attrs)
    assert location_type.description == "some description"
    assert location_type.name == "some name"
  end

  test "create_location/1 with valid data creates a location" do
    assert {:ok, %Location{} = location} = LocationManager.create_location(@location_create_attrs)
    assert location.name == "some name"
  end

  test "create_location_type/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = LocationManager.create_location_type(@location_type_invalid_attrs)
  end

  test "create_location/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = LocationManager.create_location(@location_invalid_attrs)
  end

  test "update_location_type/2 with valid data updates the location_type" do
    location_type = location_type_fixture(:location_type)
    assert {:ok, location_type} = LocationManager.update_location_type(location_type, @location_type_update_attrs)
    assert %LocationType{} = location_type
    assert location_type.description == "some updated description"
    assert location_type.name == "some updated name"
  end

  test "update_location/2 with valid data updates the location" do
    location = location_fixture(:location)
    assert {:ok, location} = LocationManager.update_location(location, @location_update_attrs)
    assert %Location{} = location
    assert location.name == "some updated name"
  end

  test "update_location_type/2 with invalid data returns error changeset" do
    location_type = location_type_fixture(:location_type)
    assert {:error, %Ecto.Changeset{}} = LocationManager.update_location_type(location_type, @location_type_invalid_attrs)
    assert location_type == LocationManager.get_location_type!(location_type.id)
  end

  test "update_location/2 with invalid data returns error changeset" do
    location = location_fixture(:location)
    assert {:error, %Ecto.Changeset{}} = LocationManager.update_location(location, @location_invalid_attrs)
    assert location == LocationManager.get_location!(location.id)
  end

  test "delete_location_type/1 deletes the location_type" do
    location_type = location_type_fixture(:location_type)
    assert {:ok, %LocationType{}} = LocationManager.delete_location_type(location_type)
    assert_raise Ecto.NoResultsError, fn -> LocationManager.get_location_type!(location_type.id) end
  end

  test "delete_location/1 deletes the location" do
    location = location_fixture(:location)
    assert {:ok, %Location{}} = LocationManager.delete_location(location)
    assert_raise Ecto.NoResultsError, fn -> LocationManager.get_location!(location.id) end
  end

  test "change_location_type/1 returns a location_type changeset" do
    location_type = location_type_fixture(:location_type)
    assert %Ecto.Changeset{} = LocationManager.change_location_type(location_type)
  end

  test "change_location/1 returns a location changeset" do
    location = location_fixture(:location)
    assert %Ecto.Changeset{} = LocationManager.change_location(location)
  end
end
