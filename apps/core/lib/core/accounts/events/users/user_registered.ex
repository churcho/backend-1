defmodule Core.Accounts.Events.UserRegistered do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :user_uuid,
    :role_uuid,
    :username,
    :email,
    :hashed_password,
  ]
end
