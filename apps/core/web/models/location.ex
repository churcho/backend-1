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
    field :latitude, :string
    field :longitude, :string

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
  end
end
