defmodule Core.DB.ConnectioThings do
  @moduledoc false
  use Core.BaseSchema
  import Ecto.Changeset

  alias Core.DB.{
    Connection,
    Thing
  }

  schema "connection_things" do
    belongs_to :connection, Connection
    belongs_to :thing, Thing
  end

  @doc false
  def changeset(connection_things, attrs) do
    connection_things
    |> cast(attrs, [
      :connection_id,
      :thing_id
    ])
    |> validate_required([

    ])
  end
end
