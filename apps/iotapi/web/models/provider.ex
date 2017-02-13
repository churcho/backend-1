defmodule Iotapi.Provider do
  use Iotapi.Web, :model

  schema "providers" do
    field :name, :string
    field :description, :string
    field :uri, :string
    field :enabled, :boolean


    has_many :services, Iotapi.Service
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :uri, :description, :enabled])
    |> validate_required([:name, :uri])
  end
end
