defmodule Core.LocationManager.Zone do
  @moduledoc """
  Zone
  """
  use Core.Web, :model

  schema "location_manager_zones" do
    field :name, :string
    field :description, :string
    field :state, :map
    belongs_to :location, Core.LocationManager.Location
    has_many :rooms, Core.LocationManager.Room
    timestamps()
  end
end
