defmodule Iotapi.EventManager.Plex do
  @moduledoc """
  Decodes the payload to JSON and creates a new map that will be used to create a new event.
  """

  @doc """
  Simple event hanler. Returns an event to the EventController
  """
  def handler(params) do
    decoded = Poison.decode!(params["payload"])

      %{
        message: decoded["Metadata"]["title"],
        type: decoded["event"],
        entity: decoded["Server"]["title"],
        payload: decoded,
        source: "plex"
      }
  end

end
