defmodule Core.Services.Events.ProviderServiceNameChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :provider_uuid,
    :service_name
  ]
end
