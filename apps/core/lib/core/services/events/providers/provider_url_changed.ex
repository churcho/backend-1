defmodule Core.Services.Events.ProviderUrlChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :provider_uuid,
    :url
  ]
end
