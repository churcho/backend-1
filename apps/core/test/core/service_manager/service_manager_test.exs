defmodule Core.ServiceManagerTest do
  @moduledoc false
  use Core.DataCase

  alias Core.ServiceManager

  describe "property_types" do
    alias Core.ServiceManager.PropertyType

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def property_type_fixture(attrs \\ %{}) do
      {:ok, property_type} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ServiceManager.create_property_type()

      property_type
    end

    test "list_property_types/0 returns all property_types" do
      property_type = property_type_fixture()
      assert ServiceManager.list_property_types() == [property_type]
    end

    test "get_property_type!/1 returns the property_type with given id" do
      property_type = property_type_fixture()
      assert ServiceManager.get_property_type!(property_type.id) == property_type
    end

    test "create_property_type/1 with valid data creates a property_type" do
      assert {:ok, %PropertyType{} = property_type} =
               ServiceManager.create_property_type(@valid_attrs)
    end

    test "create_property_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ServiceManager.create_property_type(@invalid_attrs)
    end

    test "update_property_type/2 with valid data updates the property_type" do
      property_type = property_type_fixture()

      assert {:ok, property_type} =
               ServiceManager.update_property_type(property_type, @update_attrs)

      assert %PropertyType{} = property_type
    end

    test "update_property_type/2 with invalid data returns error changeset" do
      property_type = property_type_fixture()

      assert {:error, %Ecto.Changeset{}} =
               ServiceManager.update_property_type(property_type, @invalid_attrs)

      assert property_type == ServiceManager.get_property_type!(property_type.id)
    end

    test "delete_property_type/1 deletes the property_type" do
      property_type = property_type_fixture()
      assert {:ok, %PropertyType{}} = ServiceManager.delete_property_type(property_type)

      assert_raise Ecto.NoResultsError, fn ->
        ServiceManager.get_property_type!(property_type.id)
      end
    end

    test "change_property_type/1 returns a property_type changeset" do
      property_type = property_type_fixture()
      assert %Ecto.Changeset{} = ServiceManager.change_property_type(property_type)
    end
  end

  describe "property_types" do
    alias Core.ServiceManager.PropertyType

    @valid_attrs %{entity_id: 42, property_id: 42}
    @update_attrs %{entity_id: 43, property_id: 43}
    @invalid_attrs %{entity_id: nil, property_id: nil}

    def property_type_fixture(attrs \\ %{}) do
      {:ok, property_type} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ServiceManager.create_property_type()

      property_type
    end

    test "list_property_types/0 returns all property_types" do
      property_type = property_type_fixture()
      assert ServiceManager.list_property_types() == [property_type]
    end

    test "get_property_type!/1 returns the property_type with given id" do
      property_type = property_type_fixture()
      assert ServiceManager.get_property_type!(property_type.id) == property_type
    end

    test "create_property_type/1 with valid data creates a property_type" do
      assert {:ok, %PropertyType{} = property_type} =
               ServiceManager.create_property_type(@valid_attrs)

      assert property_type.entity_id == 42
      assert property_type.property_id == 42
    end

    test "create_property_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ServiceManager.create_property_type(@invalid_attrs)
    end

    test "update_property_type/2 with valid data updates the property_type" do
      property_type = property_type_fixture()

      assert {:ok, property_type} =
               ServiceManager.update_property_type(property_type, @update_attrs)

      assert %PropertyType{} = property_type
      assert property_type.entity_id == 43
      assert property_type.property_id == 43
    end

    test "update_property_type/2 with invalid data returns error changeset" do
      property_type = property_type_fixture()

      assert {:error, %Ecto.Changeset{}} =
               ServiceManager.update_property_type(property_type, @invalid_attrs)

      assert property_type == ServiceManager.get_property_type!(property_type.id)
    end

    test "delete_property_type/1 deletes the property_type" do
      property_type = property_type_fixture()
      assert {:ok, %PropertyType{}} = ServiceManager.delete_property_type(property_type)

      assert_raise Ecto.NoResultsError, fn ->
        ServiceManager.get_property_type!(property_type.id)
      end
    end

    test "change_property_type/1 returns a property_type changeset" do
      property_type = property_type_fixture()
      assert %Ecto.Changeset{} = ServiceManager.change_property_type(property_type)
    end
  end

  describe "action_types" do
    alias Core.ServiceManager.ActionType

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def action_type_fixture(attrs \\ %{}) do
      {:ok, action_type} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ServiceManager.create_action_type()

      action_type
    end

    test "list_action_types/0 returns all action_types" do
      action_type = action_type_fixture()
      assert ServiceManager.list_action_types() == [action_type]
    end

    test "get_action_type!/1 returns the action_type with given id" do
      action_type = action_type_fixture()
      assert ServiceManager.get_action_type!(action_type.id) == action_type
    end

    test "create_action_type/1 with valid data creates a action_type" do
      assert {:ok, %ActionType{} = action_type} = ServiceManager.create_action_type(@valid_attrs)
      assert action_type.description == "some description"
      assert action_type.name == "some name"
    end

    test "create_action_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ServiceManager.create_action_type(@invalid_attrs)
    end

    test "update_action_type/2 with valid data updates the action_type" do
      action_type = action_type_fixture()
      assert {:ok, action_type} = ServiceManager.update_action_type(action_type, @update_attrs)
      assert %ActionType{} = action_type
      assert action_type.description == "some updated description"
      assert action_type.name == "some updated name"
    end

    test "update_action_type/2 with invalid data returns error changeset" do
      action_type = action_type_fixture()

      assert {:error, %Ecto.Changeset{}} =
               ServiceManager.update_action_type(action_type, @invalid_attrs)

      assert action_type == ServiceManager.get_action_type!(action_type.id)
    end

    test "delete_action_type/1 deletes the action_type" do
      action_type = action_type_fixture()
      assert {:ok, %ActionType{}} = ServiceManager.delete_action_type(action_type)
      assert_raise Ecto.NoResultsError, fn -> ServiceManager.get_action_type!(action_type.id) end
    end

    test "change_action_type/1 returns a action_type changeset" do
      action_type = action_type_fixture()
      assert %Ecto.Changeset{} = ServiceManager.change_action_type(action_type)
    end
  end

  describe "event_types" do
    alias Core.ServiceManager.EventType

    @valid_attrs %{description: "some description", name: "some name", payload: %{}}
    @update_attrs %{description: "some updated description", name: "some updated name", payload: %{}}
    @invalid_attrs %{description: nil, name: nil, payload: nil}

    def event_type_fixture(attrs \\ %{}) do
      {:ok, event_type} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ServiceManager.create_event_type()

      event_type
    end

    test "list_event_types/0 returns all event_types" do
      event_type = event_type_fixture()
      assert ServiceManager.list_event_types() == [event_type]
    end

    test "get_event_type!/1 returns the event_type with given id" do
      event_type = event_type_fixture()
      assert ServiceManager.get_event_type!(event_type.id) == event_type
    end

    test "create_event_type/1 with valid data creates a event_type" do
      assert {:ok, %EventType{} = event_type} = ServiceManager.create_event_type(@valid_attrs)
      assert event_type.description == "some description"
      assert event_type.name == "some name"
      assert event_type.payload == %{}
    end

    test "create_event_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ServiceManager.create_event_type(@invalid_attrs)
    end

    test "update_event_type/2 with valid data updates the event_type" do
      event_type = event_type_fixture()
      assert {:ok, event_type} = ServiceManager.update_event_type(event_type, @update_attrs)
      assert %EventType{} = event_type
      assert event_type.description == "some updated description"
      assert event_type.name == "some updated name"
      assert event_type.payload == %{}
    end

    test "update_event_type/2 with invalid data returns error changeset" do
      event_type = event_type_fixture()
      assert {:error, %Ecto.Changeset{}} = ServiceManager.update_event_type(event_type, @invalid_attrs)
      assert event_type == ServiceManager.get_event_type!(event_type.id)
    end

    test "delete_event_type/1 deletes the event_type" do
      event_type = event_type_fixture()
      assert {:ok, %EventType{}} = ServiceManager.delete_event_type(event_type)
      assert_raise Ecto.NoResultsError, fn -> ServiceManager.get_event_type!(event_type.id) end
    end

    test "change_event_type/1 returns a event_type changeset" do
      event_type = event_type_fixture()
      assert %Ecto.Changeset{} = ServiceManager.change_event_type(event_type)
    end
  end
end
