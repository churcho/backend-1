defmodule CouchPotatoConnect.EventHandler do
  @moduledoc """
  Handle events for huebris
  """

  def parse(params) do
    IO.puts "parse"
    parsed =
    params
    |> Poison.encode!
    |> Poison.decode!(keys: :atoms!)

    IO.inspect parsed

    %{
      service_id: parsed.service_id,
      message: parsed.message,
      type: "CouchPotatoEvent",
      entity: "Couch Potato Server",
      payload: parsed,
      source: "couchpotato"
    }
  end

end
