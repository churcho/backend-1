defmodule Core.EventManager.Sonarr do
  @moduledoc """
  Decodes the payload to JSON and creates a new map that will be used to create a new event.
  """

  @doc """
  Simple event hanler. Returns an event to the EventController
  """
  def handler(params) do
      %{
        message: params["message"],
        type: params["EventType"],
        entity: "Sonarr Server",
        payload: params,
        source: "sonarr"
      }
  end

end
