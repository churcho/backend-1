defmodule Core.Services.Events.ProviderEnabledChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :provider_uuid,
    :enabled
  ]
end
