defmodule Iotapi.Location do
  use Iotapi.Web, :model

  schema "locations" do
    field :name, :string
    field :location_state, :map
    field :address_one, :string
    field :address_two, :string
    field :city, :string
    field :state, :string
    field :zip, :string
    field :latitude, :string
    field :longitude, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :state, :address_one, :address_two, :city, :location_state, :zip, :latitude, :longitude])
    |> validate_required([:name])
  end
end
