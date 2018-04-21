defmodule Core.ZoneManager.Zone do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.ZoneManager.Zone
  alias Core.LocationManager.Location
  alias Core.RoomManager.Room

  schema "zones" do
    field :name, :string
    field :description, :string
    field :state, :map
    belongs_to :location, Location
    has_many :rooms, Room
    timestamps()
  end

  def changeset(%Zone{} = zone, attrs) do
    zone
    |> cast(attrs, [:name, :description, :state, :location_id])
    |> validate_required([:name, :description, :location_id])
  end
end
