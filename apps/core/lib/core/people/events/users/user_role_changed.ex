defmodule Core.People.Events.UserRoleChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :user_uuid,
    :role_uuid,
  ]
end
