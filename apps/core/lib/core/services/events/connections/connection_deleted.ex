defmodule Core.Services.Events.ConnectionDeleted do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :connection_uuid
  ]
end
