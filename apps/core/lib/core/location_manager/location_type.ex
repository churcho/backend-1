defmodule Core.LocationManager.LocationType do
  use Ecto.Schema

  schema "location_manager_location_types" do
    field :description, :string
    field :name, :string


    has_many :locations, Core.LocationManager.Location
    timestamps()
  end
end
