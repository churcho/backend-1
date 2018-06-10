defmodule Core.Accounts.Aggregates.UserTest do
  @moduledoc false
  use Core.AggregateCase, aggregate: Core.Accounts.Aggregates.User

  alias Core.Accounts.Events.UserRegistered

  describe "register user" do
    @tag :unit
    test "should succeed when valid" do
      user_uuid = UUID.uuid4()

      assert_events build(:register_user, user_uuid: user_uuid), [
        %UserRegistered{
          user_uuid: user_uuid,
          email: "jody@jody.me",
          username: "jody",
          hashed_password: "jodyjody",
          role_uuid: "",
        }
      ]
    end
  end
end
