defmodule Core.EventManager do
  def handle_events(params) do
     case params["source"] do
      "plex" ->
        Core.EventManager.Plex.handler(params)
      "sonarr" ->
        Core.EventManager.Sonarr.handler(params)
      "couchPotato" ->
        Core.EventManager.CouchPotato.handler(params)
      "thinkingCleaner" ->
        Core.EventManager.ThinkingCleaner.handler(params)
      "sabnzbd" ->
        Core.EventManager.SabNzbD.handler(params)
      _->
        %{ message: "Unknown Event "}
     end
  end
end
