defmodule Core.LocationManager.Room do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.LocationManager.Room

  schema "location_manager_rooms" do
    field :name, :string
    field :description, :string
    belongs_to :zone, Core.LocationManager.Zone
    has_one :zone_location, through: [:zone, :location]
    timestamps()
  end

  def changeset(%Room{} = room, attrs) do
    room
    |> cast(attrs, [:name, :description, :zone_id])
    |> validate_required([:name, :description, :zone_id])
  end
end
