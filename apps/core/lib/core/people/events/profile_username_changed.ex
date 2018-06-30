defmodule Core.People.Events.ProfileUsernameChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :profile_uuid,
    :username
  ]
end
