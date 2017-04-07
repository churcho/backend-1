defmodule Core.EventManager.Event do
  @moduledoc """
  Provides the event schema
  """
  use Core.Web, :model

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

    belongs_to :entity, Core.Entity
    belongs_to :service, Core.Service

    field :date, :utc_datetime
    field :expiration, :utc_datetime
    timestamps()
  end
end
