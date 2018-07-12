defmodule Core.Services.Projectors.Entity do
  @moduledoc false
  use Commanded.Projections.Ecto,
    name: "Services.Projectors.Entity",
    consistency: :strong

  alias Core.Services.Events.{
    EntityCreated
  }

  alias Core.Services.Projections.Entity
  alias Ecto.Multi

  project %EntityCreated{} = created do
    Multi.insert(multi, :entity, %Entity{
      uuid: created.entity_uuid,
      name: created.name,
      label: created.label,
      connection_uuid: created.connection_uuid,
      remote_id: created.remote_id,
      components: created.components
    })
  end
end
