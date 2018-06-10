defmodule Core.Accounts.Events.RoleDescriptionChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :role_uuid,
    :description
  ]
end
