defmodule Core.Services.Events.ProviderVersionChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :provider_uuid,
    :version
  ]
end
