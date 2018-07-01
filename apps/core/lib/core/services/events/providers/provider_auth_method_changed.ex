defmodule Core.Services.Events.ProviderAuthMethodChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :provider_uuid,
    :auth_method
  ]
end
