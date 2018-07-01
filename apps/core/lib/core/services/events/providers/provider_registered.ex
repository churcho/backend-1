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
    :service_name,
    :allows_import,
    :version,
    :required_fields,
    :commands,
    :keywords,
    :logo_path,
    :icon_path,
    :slug
  ]
end
