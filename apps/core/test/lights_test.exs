defmodule Core.LightsTest do
  use Core.DataCase

  alias Core.Lights
  alias Core.Lights.Entity

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  def fixture(:entity, attrs \\ @create_attrs) do
    {:ok, entity} = Lights.create_entity(attrs)
    entity
  end

  test "list_entities/1 returns all entities" do
    entity = fixture(:entity)
    assert Lights.list_entities() == [entity]
  end

  test "get_entity! returns the entity with given id" do
    entity = fixture(:entity)
    assert Lights.get_entity!(entity.id) == entity
  end

  test "create_entity/1 with valid data creates a entity" do
    assert {:ok, %Entity{} = entity} = Lights.create_entity(@create_attrs)
    assert entity.description == "some description"
    assert entity.name == "some name"
  end

  test "create_entity/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Lights.create_entity(@invalid_attrs)
  end

  test "update_entity/2 with valid data updates the entity" do
    entity = fixture(:entity)
    assert {:ok, entity} = Lights.update_entity(entity, @update_attrs)
    assert %Entity{} = entity
    assert entity.description == "some updated description"
    assert entity.name == "some updated name"
  end

  test "update_entity/2 with invalid data returns error changeset" do
    entity = fixture(:entity)
    assert {:error, %Ecto.Changeset{}} = Lights.update_entity(entity, @invalid_attrs)
    assert entity == Lights.get_entity!(entity.id)
  end

  test "delete_entity/1 deletes the entity" do
    entity = fixture(:entity)
    assert {:ok, %Entity{}} = Lights.delete_entity(entity)
    assert_raise Ecto.NoResultsError, fn -> Lights.get_entity!(entity.id) end
  end

  test "change_entity/1 returns a entity changeset" do
    entity = fixture(:entity)
    assert %Ecto.Changeset{} = Lights.change_entity(entity)
  end
end
