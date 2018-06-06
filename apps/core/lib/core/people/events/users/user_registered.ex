defmodule Core.People.Events.UserRegistered do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :user_uuid,
    :username,
    :first_name,
    :last_name,
    :role_uuid,
    :email,
    :hashed_password,
  ]
end
