defmodule Core.EventManager.SabNzbD do
  @moduledoc """
  Decodes the payload to JSON and creates a new map that will be used to create a new event.
  """

  @doc """
  Simple event hanler. Returns an event to the EventController
  """
  def handler(params) do
      %{
        message: params["message"],
        type: params["Title"],
        entity: "SabNzbD Server",
        payload: params,
        source: "sabnzbd"
      }
  end

end