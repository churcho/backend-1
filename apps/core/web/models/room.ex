defmodule Core.Room do
  use Core.Web, :model

  schema "rooms" do
    field :name, :string
    field :description, :string
    belongs_to :zone, Core.Zone
    has_one :zone_location, through: [:zone, :location]
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :zone_id])
    |> validate_required([:name, :description, :zone_id])
  end
end
