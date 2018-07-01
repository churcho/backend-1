defmodule Core.Services.Events.ProviderAllowsImportChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :provider_uuid,
    :allows_import
  ]
end
