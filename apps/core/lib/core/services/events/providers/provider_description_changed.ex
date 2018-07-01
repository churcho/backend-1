defmodule Core.Services.Events.ProviderDescriptionChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :provider_uuid,
    :description,
  ]
end
