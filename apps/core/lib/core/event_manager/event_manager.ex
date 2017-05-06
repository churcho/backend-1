defmodule Core.EventManager do
  @moduledoc """
  The boundary for the EventManager system.
  """
  require Logger
  import Ecto.{Query, Changeset}, warn: false
  alias Core.Repo
  alias Core.EventManager.Event
  alias Core.ServiceManager.Service
  alias Core.Web.EventChannel

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
    query = from(e in Event, order_by: [desc: e.id], limit: 100)
    query
    |> Repo.all
  end

  def list_entity_events_desc(entity_id) do
    query = from(e in Event, where: [entity_id: ^entity_id], order_by: [desc: e.id], limit: 100)
    query
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
    |> Event.changeset(handle_events(attrs))
    |> Repo.insert()

  end

  @doc """
  Broadcast an event to the events channel
  """

  def broadcast(event) do
    event
    |> EventChannel.broadcast_change()

    Logger.info fn ->
      "Broadcasting event #{inspect(event)}"
    end
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
    |> Event.changeset(handle_events(attrs))
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
    Event.changeset(event, %{})
  end

  @doc """
  Handle events
  """
  def handle_events(params) do

    if params["service_id"] do
      target =
      Service
      |> Repo.get(params["service_id"])
      |> Repo.preload([:provider])

      backend = Module.concat(target.provider.lorp_name, EventHandler)
      Logger.info fn ->
         "Handling events for #{target.provider.name}"
      end
      backend.parse(params)
    else
      target =
      Service
      |> Repo.get(params.service_id)
      |> Repo.preload([:provider])

      backend = Module.concat(target.provider.lorp_name, EventHandler)
      Logger.info fn ->
        "Handling events for #{target.provider.name}"
      end
      backend.parse(params)
    end

  end

  @doc """
  We will assemble the logo url using the event source field.
  """
  def logo_url(event) do
    if event.source do
      "/images/" <> event.source <> ".png"
    else
      "/images/generic.png"
    end
  end

  def icon_url(event) do
    if event.source do
      "/images/" <> event.source <> "_icon.png"
    else
      "/images/generic_icon.png"
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
