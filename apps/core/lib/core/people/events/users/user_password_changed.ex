defmodule Core.People.Events.UserPasswordChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :user_uuid,
    :hashed_password,
  ]
end
