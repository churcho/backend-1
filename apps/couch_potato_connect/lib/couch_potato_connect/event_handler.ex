defmodule CouchPotatoConnect.EventHandler do
  @moduledoc """
  Handle events for huebris
  """
  require Logger

  @doc """
  Parse function takes params and returns a valid LORP Event
  """
  def parse(params) do
    Logger.info fn ->
      "CouchPotato parsing event"
    end
    # Provider struct
    %{
      service_id: params["service_id"],
      message: params["message"],
      type: "CouchPotatoEvent",
      entity: "Couch Potato Server",
      payload: params,
      source: "couchpotato"
    }
  end
end
