defmodule Core.EventManager.Event do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.EventManager.Event

  schema "events" do
    field(:message, :string)
    field(:source, :string)
    field(:state_changed, :boolean)
    field(:permissions, :map)
    field(:payload, :map)
    field(:metadata, :map)
    timestamps()
  end

  def changeset(%Event{} = event, attrs) do
    event
    |> cast(attrs, [
      :permissions,
      :source,
      :state_changed,
      :payload,
      :metadata
    ])
    |> validate_required([])
  end
end
