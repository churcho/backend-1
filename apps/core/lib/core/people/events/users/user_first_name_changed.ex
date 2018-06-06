defmodule Core.People.Events.UserFirstNameChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :user_uuid,
    :first_name,
  ]
end
