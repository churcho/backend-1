defmodule Core.Accounts.Events.RoleNameChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :role_uuid,
    :name
  ]
end
