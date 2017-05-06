defmodule PlexConnect.EventHandler do
  @moduledoc """
  Parse and handle events for the plex connect service
  """
  require Logger


  def parse(params) do
    Logger.info fn ->
      "PlexConnect parsing event"
    end
    parsed =
    params
    |> Poison.encode!
    |> Poison.decode!(keys: :atoms!)

    decoded = Poison.decode!(parsed.payload)
    %{
      service_id: parsed.service_id,
      message: decoded["Metadata"]["title"],
      type: decoded["event"],
      entity: decoded["Server"]["title"],
      payload: decoded,
      source: "plex"
    }
  end
end
