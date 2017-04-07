defmodule Core.EventManager do
  @moduledoc """
  The boundary for the EventManager system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias Core.Repo
  alias Core.EventManager.Event

  @doc """
  Returns the list of events.

  ## Examples

      iex> list_events()
      [%Event{}, ...]

  """
  def list_events do
    Repo.all(Event)
  end

  def list_events_desc do
    result = from(e in Event, order_by: [desc: e.id], limit: 100)
    result
    |> Repo.all
  end

  def list_entity_events_desc(entity_id) do
    result = from(e in Event, where: [entity_id: ^entity_id], order_by: [desc: e.id], limit: 100)
    result
    |> Repo.all
  end

  @doc """
  Gets a single event.

  Raises `Ecto.NoResultsError` if the Event does not exist.

  ## Examples

      iex> get_event!(123)
      %Event{}

      iex> get_event!(456)
      ** (Ecto.NoResultsError)

  """
  def get_event!(id), do: Repo.get!(Event, id)

  @doc """
  Creates a event.

  ## Examples

      iex> create_event(%{field: value})
      {:ok, %Event{}}

      iex> create_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event(attrs \\ %{}) do
    %Event{}
    |> event_changeset(attrs)
    |> Repo.insert()
    |> broadcast()
  end

  @doc """
  Broadcast an event to the events channel
  """

  def broadcast(event) do
     {:ok, target} = event
     Core.Web.EventChannel.broadcast_change(target)
     event
  end

  @doc """
  Updates a event.

  ## Examples

      iex> update_event(event, %{field: new_value})
      {:ok, %Event{}}

      iex> update_event(event, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event(%Event{} = event, attrs) do
    event
    |> event_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Event.

  ## Examples

      iex> delete_event(event)
      {:ok, %Event{}}

      iex> delete_event(event)
      {:error, %Ecto.Changeset{}}

  """
  def delete_event(%Event{} = event) do
    Repo.delete(event)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking event changes.

  ## Examples

      iex> change_event(event)
      %Ecto.Changeset{source: %Event{}}

  """
  def change_event(%Event{} = event) do
    event_changeset(event, %{})
  end

  def handle_events(params) do

     case params["source"] do
      "plex" ->
        Core.EventManager.Plex.handler(params)
      "sonarr" ->
        Core.EventManager.Sonarr.handler(params)
      "couchPotato" ->
        IO.puts "Couchy!"
        Core.EventManager.CouchPotato.handler(params)
      "thinkingCleaner" ->
        Core.EventManager.ThinkingCleaner.handler(params)
      "sabnzbd" ->
        Core.EventManager.SabNzbD.handler(params)
      _ ->
        %{message: "Unknown Event "}
     end
  end

  @doc """
  We will assemble the logo url using the event source field.
  """
  def logo_url(event) do
    if event.source do
      "http://localhost:4000/images/" <> event.source <> ".png"
    else
      "http://localhost:4000/images/generic.png"
    end
  end

  def icon_url(event) do
    if event.source do
      "http://localhost:4000/images/" <> event.source <> "_icon.png"
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

  defp event_changeset(%Event{} = event, attrs) do
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
