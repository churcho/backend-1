defmodule Core.People.Events.UserEmailChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :user_uuid,
    :email,
  ]
end
