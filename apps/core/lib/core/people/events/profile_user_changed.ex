defmodule Core.People.Events.ProfileUserChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :profile_uuid,
    :user_uuid
  ]
end
