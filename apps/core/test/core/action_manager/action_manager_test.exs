defmodule Core.ActionManagerTest do
  use Core.DataCase

  alias Core.ActionManager

  describe "actions" do
    alias Core.ActionManager.Action

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def action_fixture(attrs \\ %{}) do
      {:ok, action} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ActionManager.create_action()

      action
    end

    test "list_actions/0 returns all actions" do
      action = action_fixture()
      assert ActionManager.list_actions() == [action]
    end

    test "get_action!/1 returns the action with given id" do
      action = action_fixture()
      assert ActionManager.get_action!(action.id) == action
    end

    test "create_action/1 with valid data creates a action" do
      assert {:ok, %Action{} = action} = ActionManager.create_action(@valid_attrs)
      assert action.name == "some name"
    end

    test "create_action/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ActionManager.create_action(@invalid_attrs)
    end

    test "update_action/2 with valid data updates the action" do
      action = action_fixture()
      assert {:ok, action} = ActionManager.update_action(action, @update_attrs)
      assert %Action{} = action
      assert action.name == "some updated name"
    end

    test "update_action/2 with invalid data returns error changeset" do
      action = action_fixture()
      assert {:error, %Ecto.Changeset{}} = ActionManager.update_action(action, @invalid_attrs)
      assert action == ActionManager.get_action!(action.id)
    end

    test "delete_action/1 deletes the action" do
      action = action_fixture()
      assert {:ok, %Action{}} = ActionManager.delete_action(action)
      assert_raise Ecto.NoResultsError, fn -> ActionManager.get_action!(action.id) end
    end

    test "change_action/1 returns a action changeset" do
      action = action_fixture()
      assert %Ecto.Changeset{} = ActionManager.change_action(action)
    end
  end
end
