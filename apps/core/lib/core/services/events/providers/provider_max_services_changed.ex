defmodule Core.Services.Events.ProviderMaxServicesChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :provider_uuid,
    :max_services
  ]
end
