defmodule Core.LocationManager.Room do
  @moduledoc """
  Room
  """
  use Core.Web, :model

  schema "location_manager_rooms" do
    field :name, :string
    field :description, :string
    belongs_to :zone, Core.LocationManager.Zone
    has_one :zone_location, through: [:zone, :location]
    timestamps()
  end
end
