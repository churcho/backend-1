defmodule Core.PeopleTest do
  @moduledoc false
  use Core.DataCase

  alias Core.People
  alias Core.People.Projections.User
  alias Core.Auth

  describe "register user" do
    @tag :integration
    test "should succeed with valid data" do
      assert {:ok, %User{} = user} = People.register_user(build(:user))

      assert user.username == "jody"
      assert user.email == "jody@jody.me"
    end
  end
end
