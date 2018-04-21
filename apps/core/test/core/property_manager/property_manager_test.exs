defmodule Core.PropertyManagerTest do
  use Core.DataCase

  alias Core.PropertyManager

  describe "properties" do
    alias Core.PropertyManager.Property

    @valid_attrs %{description: "some description", name: "some name", type: "some type", unit: "some unit"}
    @update_attrs %{description: "some updated description", name: "some updated name", type: "some updated type", unit: "some updated unit"}
    @invalid_attrs %{description: nil, name: nil, type: nil, unit: nil}

    def property_fixture(attrs \\ %{}) do
      {:ok, property} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PropertyManager.create_property()

      property
    end

    test "list_properties/0 returns all properties" do
      property = property_fixture()
      assert PropertyManager.list_properties() == [property]
    end

    test "get_property!/1 returns the property with given id" do
      property = property_fixture()
      assert PropertyManager.get_property!(property.id) == property
    end

    test "create_property/1 with valid data creates a property" do
      assert {:ok, %Property{} = property} = PropertyManager.create_property(@valid_attrs)
      assert property.description == "some description"
      assert property.name == "some name"
      assert property.type == "some type"
      assert property.unit == "some unit"
    end

    test "create_property/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PropertyManager.create_property(@invalid_attrs)
    end

    test "update_property/2 with valid data updates the property" do
      property = property_fixture()
      assert {:ok, property} = PropertyManager.update_property(property, @update_attrs)
      assert %Property{} = property
      assert property.description == "some updated description"
      assert property.name == "some updated name"
      assert property.type == "some updated type"
      assert property.unit == "some updated unit"
    end

    test "update_property/2 with invalid data returns error changeset" do
      property = property_fixture()
      assert {:error, %Ecto.Changeset{}} = PropertyManager.update_property(property, @invalid_attrs)
      assert property == PropertyManager.get_property!(property.id)
    end

    test "delete_property/1 deletes the property" do
      property = property_fixture()
      assert {:ok, %Property{}} = PropertyManager.delete_property(property)
      assert_raise Ecto.NoResultsError, fn -> PropertyManager.get_property!(property.id) end
    end

    test "change_property/1 returns a property changeset" do
      property = property_fixture()
      assert %Ecto.Changeset{} = PropertyManager.change_property(property)
    end
  end

  describe "range_values" do
    alias Core.PropertyManager.RanageValue

    @valid_attrs %{max: 42, min: 42}
    @update_attrs %{max: 43, min: 43}
    @invalid_attrs %{max: nil, min: nil}

    def ranage_value_fixture(attrs \\ %{}) do
      {:ok, ranage_value} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PropertyManager.create_ranage_value()

      ranage_value
    end

    test "list_range_values/0 returns all range_values" do
      ranage_value = ranage_value_fixture()
      assert PropertyManager.list_range_values() == [ranage_value]
    end

    test "get_ranage_value!/1 returns the ranage_value with given id" do
      ranage_value = ranage_value_fixture()
      assert PropertyManager.get_ranage_value!(ranage_value.id) == ranage_value
    end

    test "create_ranage_value/1 with valid data creates a ranage_value" do
      assert {:ok, %RanageValue{} = ranage_value} = PropertyManager.create_ranage_value(@valid_attrs)
      assert ranage_value.max == 42
      assert ranage_value.min == 42
    end

    test "create_ranage_value/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PropertyManager.create_ranage_value(@invalid_attrs)
    end

    test "update_ranage_value/2 with valid data updates the ranage_value" do
      ranage_value = ranage_value_fixture()
      assert {:ok, ranage_value} = PropertyManager.update_ranage_value(ranage_value, @update_attrs)
      assert %RanageValue{} = ranage_value
      assert ranage_value.max == 43
      assert ranage_value.min == 43
    end

    test "update_ranage_value/2 with invalid data returns error changeset" do
      ranage_value = ranage_value_fixture()
      assert {:error, %Ecto.Changeset{}} = PropertyManager.update_ranage_value(ranage_value, @invalid_attrs)
      assert ranage_value == PropertyManager.get_ranage_value!(ranage_value.id)
    end

    test "delete_ranage_value/1 deletes the ranage_value" do
      ranage_value = ranage_value_fixture()
      assert {:ok, %RanageValue{}} = PropertyManager.delete_ranage_value(ranage_value)
      assert_raise Ecto.NoResultsError, fn -> PropertyManager.get_ranage_value!(ranage_value.id) end
    end

    test "change_ranage_value/1 returns a ranage_value changeset" do
      ranage_value = ranage_value_fixture()
      assert %Ecto.Changeset{} = PropertyManager.change_ranage_value(ranage_value)
    end
  end

  describe "units" do
    alias Core.PropertyManager.Unit

    @valid_attrs %{enum: [], name: "some name", value: "some value"}
    @update_attrs %{enum: [], name: "some updated name", value: "some updated value"}
    @invalid_attrs %{enum: nil, name: nil, value: nil}

    def unit_fixture(attrs \\ %{}) do
      {:ok, unit} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PropertyManager.create_unit()

      unit
    end

    test "list_units/0 returns all units" do
      unit = unit_fixture()
      assert PropertyManager.list_units() == [unit]
    end

    test "get_unit!/1 returns the unit with given id" do
      unit = unit_fixture()
      assert PropertyManager.get_unit!(unit.id) == unit
    end

    test "create_unit/1 with valid data creates a unit" do
      assert {:ok, %Unit{} = unit} = PropertyManager.create_unit(@valid_attrs)
      assert unit.enum == []
      assert unit.name == "some name"
      assert unit.value == "some value"
    end

    test "create_unit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PropertyManager.create_unit(@invalid_attrs)
    end

    test "update_unit/2 with valid data updates the unit" do
      unit = unit_fixture()
      assert {:ok, unit} = PropertyManager.update_unit(unit, @update_attrs)
      assert %Unit{} = unit
      assert unit.enum == []
      assert unit.name == "some updated name"
      assert unit.value == "some updated value"
    end

    test "update_unit/2 with invalid data returns error changeset" do
      unit = unit_fixture()
      assert {:error, %Ecto.Changeset{}} = PropertyManager.update_unit(unit, @invalid_attrs)
      assert unit == PropertyManager.get_unit!(unit.id)
    end

    test "delete_unit/1 deletes the unit" do
      unit = unit_fixture()
      assert {:ok, %Unit{}} = PropertyManager.delete_unit(unit)
      assert_raise Ecto.NoResultsError, fn -> PropertyManager.get_unit!(unit.id) end
    end

    test "change_unit/1 returns a unit changeset" do
      unit = unit_fixture()
      assert %Ecto.Changeset{} = PropertyManager.change_unit(unit)
    end
  end

  describe "bool_values" do
    alias Core.PropertyManager.BoolValue

    @valid_attrs %{values: []}
    @update_attrs %{values: []}
    @invalid_attrs %{values: nil}

    def bool_value_fixture(attrs \\ %{}) do
      {:ok, bool_value} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PropertyManager.create_bool_value()

      bool_value
    end

    test "list_bool_values/0 returns all bool_values" do
      bool_value = bool_value_fixture()
      assert PropertyManager.list_bool_values() == [bool_value]
    end

    test "get_bool_value!/1 returns the bool_value with given id" do
      bool_value = bool_value_fixture()
      assert PropertyManager.get_bool_value!(bool_value.id) == bool_value
    end

    test "create_bool_value/1 with valid data creates a bool_value" do
      assert {:ok, %BoolValue{} = bool_value} = PropertyManager.create_bool_value(@valid_attrs)
      assert bool_value.values == []
    end

    test "create_bool_value/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PropertyManager.create_bool_value(@invalid_attrs)
    end

    test "update_bool_value/2 with valid data updates the bool_value" do
      bool_value = bool_value_fixture()
      assert {:ok, bool_value} = PropertyManager.update_bool_value(bool_value, @update_attrs)
      assert %BoolValue{} = bool_value
      assert bool_value.values == []
    end

    test "update_bool_value/2 with invalid data returns error changeset" do
      bool_value = bool_value_fixture()
      assert {:error, %Ecto.Changeset{}} = PropertyManager.update_bool_value(bool_value, @invalid_attrs)
      assert bool_value == PropertyManager.get_bool_value!(bool_value.id)
    end

    test "delete_bool_value/1 deletes the bool_value" do
      bool_value = bool_value_fixture()
      assert {:ok, %BoolValue{}} = PropertyManager.delete_bool_value(bool_value)
      assert_raise Ecto.NoResultsError, fn -> PropertyManager.get_bool_value!(bool_value.id) end
    end

    test "change_bool_value/1 returns a bool_value changeset" do
      bool_value = bool_value_fixture()
      assert %Ecto.Changeset{} = PropertyManager.change_bool_value(bool_value)
    end
  end
end
