defmodule Core.ServiceManagerTest do
  use Core.DataCase

  alias Core.ServiceManager

  describe "messages" do
    alias Core.ServiceManager.Message

    @valid_attrs %{payload: %{}, subject: "some subject"}
    @update_attrs %{payload: %{}, subject: "some updated subject"}
    @invalid_attrs %{payload: nil, subject: nil}

    def message_fixture(attrs \\ %{}) do
      {:ok, message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ServiceManager.create_message()

      message
    end

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert ServiceManager.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert ServiceManager.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      assert {:ok, %Message{} = message} = ServiceManager.create_message(@valid_attrs)
      assert message.payload == %{}
      assert message.subject == "some subject"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ServiceManager.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      assert {:ok, message} = ServiceManager.update_message(message, @update_attrs)
      assert %Message{} = message
      assert message.payload == %{}
      assert message.subject == "some updated subject"
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = ServiceManager.update_message(message, @invalid_attrs)
      assert message == ServiceManager.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = ServiceManager.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> ServiceManager.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = ServiceManager.change_message(message)
    end
  end
end
