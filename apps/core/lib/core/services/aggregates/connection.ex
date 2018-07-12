defmodule Core.Services.Aggregates.Connection do
  @moduledoc """
  Connection Aggregate
  """

  defstruct [
    uuid: nil,
    name: nil,
    description: nil,
    slug: nil,
    host: nil,
    port: nil,
    client_id: nil,
    client_secret: nil,
    access_token: nil,
    api_key: nil,
    enabled: nil,
    authorized: nil,
    provider_uuid: nil,
    deleted?: false
  ]

  alias Core.Services.Aggregates.Connection

  alias Core.Services.Commands.{
    CreateConnection,
    DeleteConnection
  }

  alias Core.Services.Events.{
    ConnectionCreated,
    ConnectionDeleted
  }


  def execute(%Connection{uuid: nil}, %CreateConnection{} = create) do
    %ConnectionCreated{
      connection_uuid: create.connection_uuid,
      name: create.name,
      description: create.description,
      slug: create.slug,
      host: create.host,
      port: create.port,
      client_id: create.client_id,
      client_secret: create.client_secret,
      access_token: create.access_token,
      api_key: create.api_key,
      enabled: create.enabled,
      authorized: create.authorized,
      provider_uuid: create.provider_uuid
    }
  end

  @doc """
  Delete an existing Location
  """
  def execute(
    %Connection{uuid: connection_uuid, deleted?: false},
    %DeleteConnection{connection_uuid: connection_uuid})
  do
    %ConnectionDeleted{connection_uuid: connection_uuid}
  end

  @doc """
  Stop the location aggregate after it has been deleted
  """
  def after_event(%ConnectionDeleted{}), do: :stop
  def after_event(_), do: :timer.hours(1)

  # state mutators

  def apply(%Connection{} = connection, %ConnectionCreated{} = created) do
    %Connection{connection |
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
    }
  end

  def apply(%Connection{} = connection, %ConnectionDeleted{}) do
    %Connection{connection| deleted?: true}
  end

end
