defmodule Core.AccountsTest do
  @moduledoc false
  use Core.DataCase

  alias Core.Accounts
  alias Core.Accounts.Projections.User

  describe "register user" do
    @tag :integration
    test "should succeed with valid data" do
      assert {:ok, %User{} = user} = Accounts.register_user(build(:user))

      assert user.username == "jody"
      assert user.email == "jody@jody.me"
    end

    @tag :integration
    test "should fail with invalid data and return error" do
      assert {:error, :validation_failure, errors} =
      Accounts.register_user(build(:user, username: ""))

      assert errors == %{username: ["can't be empty"]}
    end

    @tag :integration
    test "should fail when username already taken and return error" do
      assert {:ok, %User{}} = Accounts.register_user(build(:user))
      assert {:error, :validation_failure, errors} =
      Accounts.register_user(build(:user, email: "jody2@jody.me"))

      assert errors == %{username: ["has already been taken"]}
    end

    @tag :integration
    test "should fail when username format is invalid and return error" do
      assert {:error, :validation_failure, errors} =
      Accounts.register_user(build(:user, username: "j@dy"))

      assert errors == %{username: ["is invalid"]}
    end

    @tag :integration
    test "should convert username to lowercase" do
      assert {:ok, %User{} = user} =
      Accounts.register_user(build(:user, username: "JODY"))

      assert user.username == "jody"
    end

    @tag :integration
    test "should fail when email address already taken and return error" do
      assert {:ok, %User{}} =
      Accounts.register_user(build(:user, username: "jody"))
      assert {:error, :validation_failure, errors} =
      Accounts.register_user(build(:user, username: "jody2"))

      assert errors == %{email: ["has already been taken"]}
    end

  end
end
