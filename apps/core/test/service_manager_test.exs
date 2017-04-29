defmodule Core.ServiceManagerTest do
  @moduledoc false
  
  use Core.DataCase

  alias Core.ServiceManager
  alias Core.ServiceManager.EntityType

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  def fixture(:entity_type, attrs \\ @create_attrs) do
    {:ok, entity_type} = ServiceManager.create_entity_type(attrs)
    entity_type
  end

  test "list_entity_types/1 returns all entity_types" do
    entity_type = fixture(:entity_type)
    assert ServiceManager.list_entity_types() == [entity_type]
  end

  test "get_entity_type! returns the entity_type with given id" do
    entity_type = fixture(:entity_type)
    assert ServiceManager.get_entity_type!(entity_type.id) == entity_type
  end

  test "create_entity_type/1 with valid data creates a entity_type" do
    assert {:ok, %EntityType{} = entity_type} = ServiceManager.create_entity_type(@create_attrs)
    assert entity_type.description == "some description"
    assert entity_type.name == "some name"
  end

  test "create_entity_type/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = ServiceManager.create_entity_type(@invalid_attrs)
  end

  test "update_entity_type/2 with valid data updates the entity_type" do
    entity_type = fixture(:entity_type)
    assert {:ok, entity_type} = ServiceManager.update_entity_type(entity_type, @update_attrs)
    assert %EntityType{} = entity_type
    assert entity_type.description == "some updated description"
    assert entity_type.name == "some updated name"
  end

  test "update_entity_type/2 with invalid data returns error changeset" do
    entity_type = fixture(:entity_type)
    assert {:error, %Ecto.Changeset{}} = ServiceManager.update_entity_type(entity_type, @invalid_attrs)
    assert entity_type == ServiceManager.get_entity_type!(entity_type.id)
  end

  test "delete_entity_type/1 deletes the entity_type" do
    entity_type = fixture(:entity_type)
    assert {:ok, %EntityType{}} = ServiceManager.delete_entity_type(entity_type)
    assert_raise Ecto.NoResultsError, fn -> ServiceManager.get_entity_type!(entity_type.id) end
  end

  test "change_entity_type/1 returns a entity_type changeset" do
    entity_type = fixture(:entity_type)
    assert %Ecto.Changeset{} = ServiceManager.change_entity_type(entity_type)
  end
end
