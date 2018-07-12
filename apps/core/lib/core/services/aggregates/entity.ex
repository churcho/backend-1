defmodule Core.Services.Aggregates.Entity do
  @moduledoc """
  Aggregate for an Entity
  """
  defstruct [
    uuid: nil,
    name: nil,
    label: nil,
    connection_uuid: nil,
    remote_id: nil,
    components: nil
  ]

  alias Core.Services.Aggregates.Entity

  alias Core.Services.Commands.{
    CreateEntity
  }

  alias Core.Services.Events.{
    EntityCreated
  }

  def execute(%Entity{uuid: nil}, %CreateEntity{} = create) do
    %EntityCreated{
      entity_uuid: create.entity_uuid,
      name: create.name,
      label: create.label,
      connection_uuid: create.connection_uuid,
      remote_id: create.remote_id,
      components: create.components
    }
  end

   # state mutators

   def apply(%Entity{} = entity, %EntityCreated{} = created) do
    %Entity{entity |
      uuid: created.entity_uuid,
      name: created.name,
      label: created.label,
      connection_uuid: created.connection_uuid,
      remote_id: created.remote_id,
      components: created.components
    }
  end
end
