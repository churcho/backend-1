defmodule Core.Places.Projections.Location do
  @moduledoc false
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}
  schema "locations" do
    field(:name, :string)
    field(:address_one, :string)
    field(:address_two, :string)
    field(:address_city, :string)
    field(:address_country, :string)
    field(:address_state, :string)
    field(:address_zip, :string)
    field(:slug, :string)
    field(:description, :string)
    field(:latitude, :float)
    field(:longitude, :float)
    field(:location_type_uuid, :binary_id)
    field(:zones, {:array, :binary_id}, default: [])
    timestamps()
  end
end
