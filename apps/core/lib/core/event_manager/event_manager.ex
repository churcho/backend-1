defmodule Core.EventManager do
  @moduledoc """
  Boundary for the event management system
  """

  alias Core.EventManager.Event
  alias Core.Repo


  @doc """
  List All Events
  """
  def list_events do
    Repo.all(Event)
  end

  @doc """
  Create a new Location.
  """
  def create_event(attrs \\ %{}) do
    %Event{}
    |> Event.changeset(attrs)
    |> Repo.insert()
  end
end
