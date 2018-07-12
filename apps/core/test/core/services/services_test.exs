defmodule Core.ServicesTest do
  use Core.DataCase

  alias Core.Services

  describe "entities" do
    alias Core.Services.Entity

    @valid_attrs %{name: "some name", service_uuid: "7488a646-e31f-11e4-aace-600308960662"}
    @update_attrs %{name: "some updated name", service_uuid: "7488a646-e31f-11e4-aace-600308960668"}
    @invalid_attrs %{name: nil, service_uuid: nil}

    def entity_fixture(attrs \\ %{}) do
      {:ok, entity} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Services.create_entity()

      entity
    end

    test "list_entities/0 returns all entities" do
      entity = entity_fixture()
      assert Services.list_entities() == [entity]
    end

    test "get_entity!/1 returns the entity with given id" do
      entity = entity_fixture()
      assert Services.get_entity!(entity.id) == entity
    end

    test "create_entity/1 with valid data creates a entity" do
      assert {:ok, %Entity{} = entity} = Services.create_entity(@valid_attrs)
      assert entity.name == "some name"
      assert entity.service_uuid == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_entity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Services.create_entity(@invalid_attrs)
    end

    test "update_entity/2 with valid data updates the entity" do
      entity = entity_fixture()
      assert {:ok, entity} = Services.update_entity(entity, @update_attrs)
      assert %Entity{} = entity
      assert entity.name == "some updated name"
      assert entity.service_uuid == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_entity/2 with invalid data returns error changeset" do
      entity = entity_fixture()
      assert {:error, %Ecto.Changeset{}} = Services.update_entity(entity, @invalid_attrs)
      assert entity == Services.get_entity!(entity.id)
    end

    test "delete_entity/1 deletes the entity" do
      entity = entity_fixture()
      assert {:ok, %Entity{}} = Services.delete_entity(entity)
      assert_raise Ecto.NoResultsError, fn -> Services.get_entity!(entity.id) end
    end

    test "change_entity/1 returns a entity changeset" do
      entity = entity_fixture()
      assert %Ecto.Changeset{} = Services.change_entity(entity)
    end
  end
end
