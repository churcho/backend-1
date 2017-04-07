defmodule Core.LocationManager.Location do
  use Core.Web, :model

  schema "location_manager_locations" do
    field :name, :string
    field :state, :map
    field :metadata, :map
    field :address_one, :string
    field :address_two, :string
    field :address_city, :string
    field :address_state, :string
    field :address_zip, :string
    field :slug, :string
    field :description, :string
    field :latitude, :float
    field :longitude, :float

    belongs_to :location_type, Core.LocationManager.LocationType
    has_many :zones, Core.LocationManager.Zone
    has_many :zone_rooms, through: [:zones, :room]
    timestamps()
  end
end
