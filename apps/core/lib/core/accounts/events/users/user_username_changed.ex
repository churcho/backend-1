defmodule Core.Accounts.Events.UserUsernameChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :user_uuid,
    :username,
  ]
end
