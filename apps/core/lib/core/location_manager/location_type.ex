defmodule Core.LocationManager.LocationType do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.LocationManager.LocationType

  schema "location_manager_location_types" do
    field(:description, :string)
    field(:name, :string)

    has_many(:locations, Core.LocationManager.Location)
    timestamps()
  end

  def changeset(%LocationType{} = location_type, attrs) do
    location_type
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
