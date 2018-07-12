defmodule Core.Services.Projectors.Connection do
  @moduledoc false
  use Commanded.Projections.Ecto,
    name: "Services.Projectors.Connection",
    consistency: :strong

  alias Core.Services.Events.{
    ConnectionCreated,
    ConnectionDeleted
  }

  alias Core.Services.Projections.Connection
  alias Ecto.Multi

  project %ConnectionCreated{} = created do
    Multi.insert(multi, :connection, %Connection{
      uuid: created.connection_uuid,
      name: created.name,
      description: created.description,
      slug: created.slug,
      host: created.host,
      port: created.port,
      client_id: created.client_id,
      client_secret: created.client_secret,
      access_token: created.access_token,
      api_key: created.api_key,
      enabled: created.enabled,
      authorized: created.authorized,
      provider_uuid: created.provider_uuid
    })
  end

  project %ConnectionDeleted{connection_uuid: connection_uuid} do
    Multi.delete_all(multi, :connection, connection_query(connection_uuid))
  end

  defp connection_query(connection_uuid) do
    from(c in Connection, where: c.uuid == ^connection_uuid)
  end


end
