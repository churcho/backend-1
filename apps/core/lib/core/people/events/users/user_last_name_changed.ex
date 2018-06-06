defmodule Core.People.Events.UserLastNameChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :user_uuid,
    :last_name,
  ]
end
