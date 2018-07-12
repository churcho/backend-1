defmodule Core.Services.Commands.CreateEntity do
  @moduledoc false

  defstruct [
    entity_uuid: "",
    name: "",
    label: "",
    connection_uuid: "",
    remote_id: "",
    components: nil
  ]

  use ExConstructor
  use Vex.Struct

  alias Core.Services.Commands.CreateEntity

  validates :entity_uuid, uuid: true

  def assign_uuid(%CreateEntity{} = create_entity, uuid) do
    %CreateEntity{create_entity | entity_uuid: uuid}
  end
end
