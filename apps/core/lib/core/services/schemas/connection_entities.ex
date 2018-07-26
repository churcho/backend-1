defmodule Core.DB.ConnectionEntities do
  @moduledoc false
  use Core.BaseSchema
  import Ecto.Changeset

  alias Core.DB.{
    Connection,
    Entity
  }

  schema "connection_entities" do
    belongs_to :connection, Connection
    belongs_to :entity, Entity
  end

  @doc false
  def changeset(connection_entities, attrs) do
    connection_entities
    |> cast(attrs, [
      :connection_id,
      :entity_id
    ])
    |> validate_required([

    ])
  end
end
