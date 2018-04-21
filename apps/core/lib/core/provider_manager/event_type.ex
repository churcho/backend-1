defmodule Core.ProviderManager.EventType do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.ProviderManager.EventType
  alias Core.ProviderManager.Provider
  alias Core.EventManager.Event

  schema "event_types" do
    field(:description, :string)
    field(:name, :string)
    field(:payload, :map)

    belongs_to(:provider, Provider)
    belongs_to(:event, Event)
    timestamps()
  end

  @doc false
  def changeset(%EventType{} = event_type, attrs) do
    event_type
    |> cast(attrs, [:name, :description, :payload])
    |> validate_required([:name, :description, :payload])
  end
end
