defmodule Core.Factory do
  @moduledoc false
  use ExMachina

  alias Core.People.Commands.RegisterUser

  def user_factory do
    %{
      email: "jake@jake.jake",
      username: "jake",
      password: "jakejake",
      hashed_password: "jakejake"
    }
  end

  def register_user_factory do
    struct(RegisterUser, build(:user))
  end
end
