defmodule Core.Zone do
  use Core.Web, :model

  schema "zones" do
    field :name, :string
    field :description, :string
    field :state, :map
    belongs_to :location, Core.Location
    has_many :rooms, Core.Room
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :state, :location_id])
    |> validate_required([:name, :description, :location_id])
  end
end
