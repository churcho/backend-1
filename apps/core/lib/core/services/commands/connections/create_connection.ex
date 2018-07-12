defmodule Core.Services.Commands.CreateConnection do
  @moduledoc false

  defstruct [
    connection_uuid: "",
    name: "",
    description: "",
    slug: "",
    host: "",
    port: "",
    client_id: "",
    client_secret: "",
    access_token: "",
    api_key: "",
    enabled: nil,
    authorized: nil,
    provider_uuid: ""
  ]

  use ExConstructor
  use Vex.Struct

  alias Core.Services.Commands.CreateConnection

  validates :connection_uuid, uuid: true

  def assign_uuid(%CreateConnection{} = create_connection, uuid) do
    %CreateConnection{create_connection | connection_uuid: uuid}
  end
end
