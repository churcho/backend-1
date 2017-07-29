defmodule Core.ConnectionManager.Light do
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.ConnectionManager.Light


  schema "lights" do
    belongs_to :entity, Core.ServiceManager.Entity
    belongs_to :room, Core.LocationManager.Room

    timestamps()
  end

  @doc false
  def changeset(%Light{} = light, attrs) do
    light
    |> cast(attrs, [:entity_id, :room_id])
    |> validate_required([:entity_id, :room_id])
  end
end
