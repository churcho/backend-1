defmodule Iotapi.Zone do
  use Iotapi.Web, :model

  schema "zones" do
    field :name, :string
    field :description, :string
    field :state, :map
    belongs_to :location, Iotapi.Location

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :state, :location_id])
    |> validate_required([:name, :description])
  end
end
