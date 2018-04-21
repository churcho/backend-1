defmodule Core.ServiceManager.EventType do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.ServiceManager.EventType
  alias Core.ServiceManager.Service
  alias Core.EventManager.Event

  schema "event_types" do
    field(:description, :string)
    field(:name, :string)
    field(:payload, :map)

    belongs_to(:event, Event)
    belongs_to(:service, Service)
    timestamps()
  end

  @doc false
  def changeset(%EventType{} = event_type, attrs) do
    event_type
    |> cast(attrs, [:service_id, :event_id, :name, :description, :payload])
    |> validate_required([:name, :description, :payload])
  end
end
