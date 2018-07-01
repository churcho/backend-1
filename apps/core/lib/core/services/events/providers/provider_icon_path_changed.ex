defmodule Core.Services.Events.ProviderIconPathChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :provider_uuid,
    :icon_path,
  ]
end
