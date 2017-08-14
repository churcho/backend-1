defmodule Core.ServiceManager.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.ServiceManager.Message


  schema "messages" do
    field :payload, :map
    field :subject, :string

    belongs_to :entity, Core.ServiceManager.Entity

    timestamps()
  end

  @doc false
  def changeset(%Message{} = message, attrs) do
    message
    |> cast(attrs, [:subject, :payload, :entity_id])
    |> validate_required([:subject, :payload])
  end
end
