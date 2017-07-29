defmodule Core.ConnectionManagerTest do
  use Core.DataCase

  alias Core.ConnectionManager

  describe "lights" do
    alias Core.ConnectionManager.Light

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def light_fixture(attrs \\ %{}) do
      {:ok, light} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ConnectionManager.create_light()

      light
    end

    test "list_lights/0 returns all lights" do
      light = light_fixture()
      assert ConnectionManager.list_lights() == [light]
    end

    test "get_light!/1 returns the light with given id" do
      light = light_fixture()
      assert ConnectionManager.get_light!(light.id) == light
    end

    test "create_light/1 with valid data creates a light" do
      assert {:ok, %Light{} = light} = ConnectionManager.create_light(@valid_attrs)
    end

    test "create_light/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ConnectionManager.create_light(@invalid_attrs)
    end

    test "update_light/2 with valid data updates the light" do
      light = light_fixture()
      assert {:ok, light} = ConnectionManager.update_light(light, @update_attrs)
      assert %Light{} = light
    end

    test "update_light/2 with invalid data returns error changeset" do
      light = light_fixture()
      assert {:error, %Ecto.Changeset{}} = ConnectionManager.update_light(light, @invalid_attrs)
      assert light == ConnectionManager.get_light!(light.id)
    end

    test "delete_light/1 deletes the light" do
      light = light_fixture()
      assert {:ok, %Light{}} = ConnectionManager.delete_light(light)
      assert_raise Ecto.NoResultsError, fn -> ConnectionManager.get_light!(light.id) end
    end

    test "change_light/1 returns a light changeset" do
      light = light_fixture()
      assert %Ecto.Changeset{} = ConnectionManager.change_light(light)
    end
  end
end
