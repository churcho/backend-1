defmodule Core.LocationManager.Location do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.LocationManager.Location

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

  def changeset(%Location{} = location, attrs) do
    location
    |> cast(attrs, [:name, :state, :address_state, :address_one, :address_two, :address_city, :address_zip, :latitude, :longitude])
    |> validate_required([:name])
    |> update_zip
  end

  defp update_zip(changeset) do
    service = Core.ServiceManager.get_service_by_name("Geocoder")
    location = %{
       address_one: get_change(changeset, :address_one),
       address_city: get_change(changeset, :address_city),
       address_state: get_change(changeset, :address_state),
       address_zip: get_change(changeset, :address_zip)
    }
    if service != nil do
    address = Core.Geocoder.compose_address(location)
      if address != nil do
        coords = Core.Geocoder.get_coords(address, service.api_key)
        changeset
        |> put_change(:latitude, coords.lat)
        |> put_change(:longitude, coords.lng)
      else
        changeset
      end
    else
      changeset
    end
  end
end
