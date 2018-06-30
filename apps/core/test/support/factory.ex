defmodule Core.Factory do
  @moduledoc false
  use ExMachina

  alias Core.Accounts.Commands.RegisterUser

  def user_factory do
    %{
      email: "jody@jody.me",
      username: "jody",
      password: "jodyjody",
      hashed_password: "jodyjody"
    }
  end

  def register_user_factory do
    struct(RegisterUser, build(:user))
  end
end
