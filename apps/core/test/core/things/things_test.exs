defmodule Core.ThingsTest do
  use Core.DataCase

  alias Core.Things

  describe "doors" do
    alias Core.Things.Door

    @valid_attrs %{locked_state: "some locked_state", open_state: "some open_state", provider_uuid: "some provider_uuid", room_uuid: "some room_uuid", service_uuid: "some service_uuid"}
    @update_attrs %{locked_state: "some updated locked_state", open_state: "some updated open_state", provider_uuid: "some updated provider_uuid", room_uuid: "some updated room_uuid", service_uuid: "some updated service_uuid"}
    @invalid_attrs %{locked_state: nil, open_state: nil, provider_uuid: nil, room_uuid: nil, service_uuid: nil}

    def door_fixture(attrs \\ %{}) do
      {:ok, door} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Things.create_door()

      door
    end

    test "list_doors/0 returns all doors" do
      door = door_fixture()
      assert Things.list_doors() == [door]
    end

    test "get_door!/1 returns the door with given id" do
      door = door_fixture()
      assert Things.get_door!(door.id) == door
    end

    test "create_door/1 with valid data creates a door" do
      assert {:ok, %Door{} = door} = Things.create_door(@valid_attrs)
      assert door.locked_state == "some locked_state"
      assert door.open_state == "some open_state"
      assert door.provider_uuid == "some provider_uuid"
      assert door.room_uuid == "some room_uuid"
      assert door.service_uuid == "some service_uuid"
    end

    test "create_door/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Things.create_door(@invalid_attrs)
    end

    test "update_door/2 with valid data updates the door" do
      door = door_fixture()
      assert {:ok, door} = Things.update_door(door, @update_attrs)
      assert %Door{} = door
      assert door.locked_state == "some updated locked_state"
      assert door.open_state == "some updated open_state"
      assert door.provider_uuid == "some updated provider_uuid"
      assert door.room_uuid == "some updated room_uuid"
      assert door.service_uuid == "some updated service_uuid"
    end

    test "update_door/2 with invalid data returns error changeset" do
      door = door_fixture()
      assert {:error, %Ecto.Changeset{}} = Things.update_door(door, @invalid_attrs)
      assert door == Things.get_door!(door.id)
    end

    test "delete_door/1 deletes the door" do
      door = door_fixture()
      assert {:ok, %Door{}} = Things.delete_door(door)
      assert_raise Ecto.NoResultsError, fn -> Things.get_door!(door.id) end
    end

    test "change_door/1 returns a door changeset" do
      door = door_fixture()
      assert %Ecto.Changeset{} = Things.change_door(door)
    end
  end
end
