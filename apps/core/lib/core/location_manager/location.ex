defmodule Core.LocationManager.Location do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.LocationManager.Location
  alias Core.LocationManager.LocationType
  alias Core.ZoneManager.Zone
  alias Core.LocationManager.PropertyType

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

    has_many(
      :property_types,
      PropertyType,
      on_delete: :delete_all
    )

    has_many(
      :location_properties,
      through: [:property_types, :property]
    )

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
  end
end
