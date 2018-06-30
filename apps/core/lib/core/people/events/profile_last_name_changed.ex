defmodule Core.People.Events.ProfileLastNameChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :profile_uuid,
    :last_name,
  ]
end
