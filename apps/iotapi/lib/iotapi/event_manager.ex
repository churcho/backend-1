defmodule Iotapi.EventManager do
  def handle_events(params) do
     case params["source"] do
      "plex" ->
        Iotapi.EventManager.Plex.handler(params)
      "sonarr" ->
        Iotapi.EventManager.Sonarr.handler(params)
      "couchPotato" ->
        Iotapi.EventManager.CouchPotato.handler(params)
      "thinkingCleaner" ->
        Iotapi.EventManager.ThinkingCleaner.handler(params)
      "sabnzbd" ->
        Iotapi.EventManager.SabNzbD.handler(params)
      _->
        %{ message: "Unknown Event "}
     end
  end
end
