defmodule Core.Services.Events.ProviderLogoPathChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :provider_uuid,
    :logo_path
  ]
end
