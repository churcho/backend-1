defmodule Iotapi.Event do
  use Iotapi.Web, :model

  schema "events" do
    field :message, :string
    field :entity, :string
    field :value, :string
    field :units, :string
    field :date, :utc_datetime
    field :source, :string
    field :type, :string
    field :state_changed, :boolean
    field :payload, :map



    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:message, :entity, :value, :units, :date, :source, :type, :state_changed, :payload])
    |> validate_required([])
  end
end
