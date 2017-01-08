defmodule Iotapi.EventTest do
  use Iotapi.ModelCase

  alias Iotapi.Event

  @valid_attrs %{entity: "some content", message: "some content", payload: %{}, type: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Event.changeset(%Event{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Event.changeset(%Event{}, @invalid_attrs)
    refute changeset.valid?
  end
end
