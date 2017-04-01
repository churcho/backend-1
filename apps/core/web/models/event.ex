defmodule Core.Event do
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

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:message, 
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


  @doc """
  We will assemble the logo url using the event source field.
  """
  def logo_url(event) do
    if event.source do
      "http://localhost:4000/images/"<>event.source<>".png"
    else
      "http://localhost:4000/images/generic.png"
    end
  end

  def icon_url(event) do
    if event.source do
      "http://localhost:4000/images/"<>event.source<>"_icon.png"
    else
      "http://localhost:4000/images/generic_icon.png"
    end
  end

  @doc """
  Let's trim the message string down to a more manageable size.
  """
  def trimmed_title(title) do
    title
    |> String.slice(0..18)
    |> String.replace(~r{-[^-]*$}, "")
  end
end
