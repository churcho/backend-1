defmodule Core.LocationManager.LocationType do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.LocationManager.LocationType

  schema "location_types" do
    field(:description, :string)
    field(:name, :string)
    field(:label, :string)
    has_many(:locations, Core.LocationManager.Location)
    timestamps()
  end

  def changeset(%LocationType{} = location_type, attrs) do
    location_type
    |> cast(attrs, [:name, :label, :description])
    |> validate_format(:name, ~r/^[a-z_]+$/)
    |> validate_required([:name, :description, :label])
  end
end
