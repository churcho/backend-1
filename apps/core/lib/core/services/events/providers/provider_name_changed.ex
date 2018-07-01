defmodule Core.Services.Events.ProviderNameChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :provider_uuid,
    :name
  ]
end
