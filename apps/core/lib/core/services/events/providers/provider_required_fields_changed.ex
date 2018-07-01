defmodule Core.Services.Events.ProviderRequiredFieldsChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :provider_uuid,
    :required_fields,
  ]
end
