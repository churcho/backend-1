defmodule Core.People.Events.ProfileFirstNameChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :profile_uuid,
    :first_name,
  ]
end
