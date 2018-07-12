defmodule Core.Services.Commands.DeleteConnection do
  @moduledoc false
  defstruct [
    connection_uuid: "",
  ]

  use ExConstructor
  use Vex.Struct

  alias Core.Services.Projections.Connection
  alias Core.Services.Commands.DeleteConnection

  validates :connection_uuid, uuid: true

  def assign_connection(%DeleteConnection{} = delete, %Connection{uuid: connection_uuid}) do
    %DeleteConnection{delete |
      connection_uuid: connection_uuid,
    }
  end

end
