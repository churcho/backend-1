defmodule Core.Event do
  use Core.Web, :model

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
    |> cast(params, [:message, :entity, :value, :units, :date, :source, :type, :state_changed, :payload, :inserted_at])
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
