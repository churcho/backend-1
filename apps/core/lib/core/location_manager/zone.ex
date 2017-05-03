defmodule Core.LocationManager.Zone do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.LocationManager.Zone

  schema "location_manager_zones" do
    field :name, :string
    field :description, :string
    field :state, :map
    belongs_to :location, Core.LocationManager.Location
    has_many :rooms, Core.LocationManager.Room
    timestamps()
  end

  def changeset(%Zone{} = zone, attrs) do
    zone
    |> cast(attrs, [:name, :description, :state, :location_id])
    |> validate_required([:name, :description, :location_id])
  end
end
