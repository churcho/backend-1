defmodule Core.Services.Events.ProviderRegistered do
  @moduledoc false

  @derive [Poison.Encoder]

  defstruct [
    :provider_uuid,
    :name,
    :description,
    :url,
    :enabled,
    :auth_method,
    :max_services,
    :allows_import,
    :version,
    :keywords,
    :logo_path,
    :icon_path,
    :slug,
  ]
end
