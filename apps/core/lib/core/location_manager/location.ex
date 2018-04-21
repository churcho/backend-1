defmodule Core.LocationManager.Location do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.LocationManager.Location
  alias Core.LocationManager.LocationType
  alias Core.ZoneManager.Zone
  alias Core.ServiceManager
  alias Core.Geocoder

  schema "locations" do
    field(:name, :string)
    field(:address_one, :string)
    field(:address_two, :string)
    field(:address_city, :string)
    field(:address_state, :string)
    field(:address_zip, :string)
    field(:slug, :string)
    field(:description, :string)
    field(:latitude, :float)
    field(:longitude, :float)
    field(:state, :map)
    field(:metadata, :map)

    belongs_to(:location_type, LocationType)
    has_many(:zones, Zone)
    has_many(:zone_rooms, through: [:zones, :room])
    timestamps()
  end

  def changeset(%Location{} = location, attrs) do
    location
    |> cast(attrs, [
      :name,
      :address_state,
      :address_one,
      :address_two,
      :address_city,
      :address_zip,
      :latitude,
      :longitude,
      :state,
      :metadata
    ])
    |> validate_required([:name])
    |> update_zip
  end

  defp update_zip(changeset) do
    service = ServiceManager.get_service_by_name("Gecode")

    location = %{
      address_one: get_change(changeset, :address_one),
      address_city: get_change(changeset, :address_city),
      address_state: get_change(changeset, :address_state),
      address_zip: get_change(changeset, :address_zip)
    }

    if service != nil do
      address = Geocoder.compose_address(location)

      if address != nil do
        coords = Geocoder.get_coords(address, service.api_key)

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
