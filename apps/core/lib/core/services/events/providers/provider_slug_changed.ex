defmodule Core.Services.Events.ProviderSlugChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :provider_uuid,
    :slug
  ]
end
