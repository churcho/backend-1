defmodule Core.Services.Events.EntityCreated do
  @moduledoc false

  @derive [Poison.Encoder]
  defstruct [
    :entity_uuid,
    :name,
    :label,
    :connection_uuid,
    :remote_id,
    :components
  ]
end
