 defmodule Core.LocationManager.Location do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.LocationManager.Location

  schema "location_manager_locations" do
    field :name, :string
    field :address_one, :string
    field :address_two, :string
    field :address_city, :string
    field :address_state, :string
    field :address_zip, :string
    field :slug, :string
    field :description, :string
    field :latitude, :float
    field :longitude, :float


    embeds_one :metadata, MetaData do
      field :send_emails, :boolean
    end

    embeds_one :state, State do
      field :indoor_temperature, :float
      field :outdoor_temperature, :float
      field :indoor_humidity, :float
      field :outdoor_humidity, :float
      field :outdoor_windspeed, :float
      field :outdoor_airpressure, :float
      field :outdoor_ozone, :float
      field :outdoor_dewpoint, :float
    end

    belongs_to :location_type, Core.LocationManager.LocationType
    has_many :zones, Core.LocationManager.Zone
    has_many :zone_rooms, through: [:zones, :room]
    timestamps()
  end

  def changeset(%Location{} = location, attrs) do
    location
    |> cast(attrs, [:name,
                    :address_state,
                    :address_one,
                    :address_two,
                    :address_city,
                    :address_zip,
                    :latitude,
                    :longitude])
    |> cast_embed(:state,  with: &state_changeset/2)
    |> cast_embed(:metadata,  with: &metadata_changeset/2)
    |> validate_required([:name])
    |> update_zip
  end

  defp state_changeset(schema, params) do
     schema
     |> cast(params, [
       :indoor_temperature,
       :outdoor_temperature,
       :indoor_humidity,
       :outdoor_humidity,
       :outdoor_windspeed,
       :outdoor_airpressure,
       :outdoor_ozone,
       :outdoor_dewpoint
       ])
  end

  defp metadata_changeset(schema, params) do
     schema
     |> cast(params, [:send_emails])
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
