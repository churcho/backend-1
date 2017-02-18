defmodule Iotapi.EventManager.ThinkingCleaner do
  @moduledoc """
  Decodes the payload to JSON and creates a new map that will be used to create a new event.
  """

  @doc """
  Simple event hanler. Returns an event to the EventController
  """
  def handler(params) do
      %{
        message: "Morty is active",
        type: "trigger",
        entity: "Morty",
        source: "Thinking Cleaner"
      }
  end

end
