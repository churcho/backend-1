defmodule Core.Accounts.Events.RoleCreated do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :role_uuid,
    :name,
    :description,
    :label
  ]
end
