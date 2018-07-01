defmodule Core.Services.Events.ProviderKeywordsChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :provider_uuid,
    :keywords
  ]
end
