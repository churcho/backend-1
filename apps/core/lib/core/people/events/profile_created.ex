defmodule Core.People.Events.ProfileCreated do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :profile_uuid,
    :user_uuid,
    :username,
    :first_name,
    :last_name,
    :user_uuid
  ]
end
