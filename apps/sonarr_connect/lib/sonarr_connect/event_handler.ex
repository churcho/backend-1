defmodule SonarrConnect.EventHandler do
  @moduledoc """
  Parse and handle events for the plex connect service
  """

  def parse(params) do
    %{
      service_id: params["service_id"],
      message: params["message"],
      type: params["EventType"],
      entity: "Sonarr Server",
      payload: params,
      source: "sonarr"
    }
  end
end
