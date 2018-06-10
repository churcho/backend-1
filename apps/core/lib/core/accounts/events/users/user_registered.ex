defmodule Core.Accounts.Events.UserRegistered do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :user_uuid,
    :username,
    :role_uuid,
    :email,
    :hashed_password,
  ]
end
