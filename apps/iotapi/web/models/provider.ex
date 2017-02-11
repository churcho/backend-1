defmodule Iotapi.Provider do
  use Iotapi.Web, :model

  schema "providers" do
    field :name, :string
    field :uri, :string
    field :callback_uri, :string

    has_many :services, Iotapi.Service
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :uri, :callback_uri])
    |> validate_required([:name, :uri, :callback_uri])
  end
end
