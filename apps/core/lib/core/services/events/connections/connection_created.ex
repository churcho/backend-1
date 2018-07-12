defmodule Core.Services.Events.ConnectionCreated do
  @moduledoc false

  @derive [Poison.Encoder]
  defstruct [
    :connection_uuid,
    :name,
    :description,
    :slug,
    :host,
    :port,
    :client_id,
    :client_secret,
    :access_token,
    :api_key,
    :enabled,
    :authorized,
    :provider_uuid
  ]
end
