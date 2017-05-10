defmodule Core.EventManager.Event do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.EventManager.Event

  schema "events" do
    field :message, :string
    field :uuid, :string
    field :value, :string
    field :units, :string
    field :source, :string
    field :source_event, :string
    field :type, :string
    field :state_changed, :boolean
    field :permissions, :map
    field :payload, :map
    field :metadata, :map

    belongs_to :entity, Core.ServiceManager.Entity
    belongs_to :service, Core.ServiceManager.Service

    field :date, :utc_datetime
    field :expiration, :utc_datetime
    timestamps()
  end

  def changeset(%Event{} = event, attrs) do
    event
    |> cast(attrs, [:message,
                     :permissions,
                     :value,
                     :units,
                     :date,
                     :source,
                     :source_event,
                     :type,
                     :state_changed,
                     :payload,
                     :metadata,
                     :expiration,
                     :service_id,
                     :entity_id,
                     :inserted_at])
    |> validate_required([])
  end
end
