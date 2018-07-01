defmodule Core.Services.Events.ProviderCommandsChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :provider_uuid,
    :commands
  ]
end
