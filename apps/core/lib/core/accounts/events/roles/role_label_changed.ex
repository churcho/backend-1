defmodule Core.Accounts.Events.RoleLabelChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :role_uuid,
    :label
  ]
end
