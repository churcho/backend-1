defmodule Iotapi.Event do
  use Iotapi.Web, :model

  schema "events" do
    field :message, :string
    field :entity, :string
    field :type, :string
    field :payload, :map
    field :date, :utc_datetime

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:message, :entity, :type, :payload, :date])
    |> validate_required([:message, :entity, :type])
  end
end
