defmodule Core.LocationManagerTest do
  use Core.DataCase

  alias Core.LocationManager

  describe "states" do
    alias Core.LocationManager.State

    @valid_attrs %{indoor_temperautre: 120.5, outdoor_temperature: 120.5}
    @update_attrs %{indoor_temperautre: 456.7, outdoor_temperature: 456.7}
    @invalid_attrs %{indoor_temperautre: nil, outdoor_temperature: nil}

    def state_fixture(attrs \\ %{}) do
      {:ok, state} =
        attrs
        |> Enum.into(@valid_attrs)
        |> LocationManager.create_state()

      state
    end

    test "list_states/0 returns all states" do
      state = state_fixture()
      assert LocationManager.list_states() == [state]
    end

    test "get_state!/1 returns the state with given id" do
      state = state_fixture()
      assert LocationManager.get_state!(state.id) == state
    end

    test "create_state/1 with valid data creates a state" do
      assert {:ok, %State{} = state} = LocationManager.create_state(@valid_attrs)
      assert state.indoor_temperautre == 120.5
      assert state.outdoor_temperature == 120.5
    end

    test "create_state/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = LocationManager.create_state(@invalid_attrs)
    end

    test "update_state/2 with valid data updates the state" do
      state = state_fixture()
      assert {:ok, state} = LocationManager.update_state(state, @update_attrs)
      assert %State{} = state
      assert state.indoor_temperautre == 456.7
      assert state.outdoor_temperature == 456.7
    end

    test "update_state/2 with invalid data returns error changeset" do
      state = state_fixture()
      assert {:error, %Ecto.Changeset{}} = LocationManager.update_state(state, @invalid_attrs)
      assert state == LocationManager.get_state!(state.id)
    end

    test "delete_state/1 deletes the state" do
      state = state_fixture()
      assert {:ok, %State{}} = LocationManager.delete_state(state)
      assert_raise Ecto.NoResultsError, fn -> LocationManager.get_state!(state.id) end
    end

    test "change_state/1 returns a state changeset" do
      state = state_fixture()
      assert %Ecto.Changeset{} = LocationManager.change_state(state)
    end
  end
end
