defmodule Iotapi.EventManager.CouchPotato do
  @moduledoc """
  Decodes the payload to JSON and creates a new map that will be used to create a new event.
  """

  @doc """
  Simple event hanler. Returns an event to the EventController
  """
  def handler(params) do
      %{
        message: params["message"],
        type: "CouchPotatoEvent",
        entity: "Couch Potato Server",
        payload: params,
        source: "couchpotato"
      }
  end

end
