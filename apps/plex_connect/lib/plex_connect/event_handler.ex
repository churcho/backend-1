defmodule PlexConnect.EventHandler do
  @moduledoc """
  Parse and handle events for the plex connect service
  """

  def parse(params) do
    IO.puts "parse"
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
