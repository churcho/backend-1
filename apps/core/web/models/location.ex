defmodule Core.Location do
  use Core.Web, :model

  schema "locations" do
    field :name, :string
    field :state, :map
    field :address_one, :string
    field :address_two, :string
    field :address_city, :string
    field :address_state, :string
    field :address_zip, :string
    field :latitude, :float
    field :longitude, :float

    has_many :zones, Core.Zone
    has_many :zone_rooms, through: [:zones, :room]
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :state, :address_state, :address_one, :address_two, :address_city, :address_zip, :latitude, :longitude])
    |> validate_required([:name])
    |> update_zip
  end


  defp update_zip(changeset) do
    service = Core.Repo.get_by(Core.Service, name: "Geocoder")
      location = %{
         address_one: get_change(changeset, :address_one),
         address_city: get_change(changeset, :address_city),
         address_state: get_change(changeset, :address_state),
         address_zip: get_change(changeset, :address_zip)
      }
    if service != nil do
      address = Core.Geocoder.compose_address(location)
      IO.inspect address
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
