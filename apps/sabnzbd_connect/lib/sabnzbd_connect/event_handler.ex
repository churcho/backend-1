defmodule SabNzbDConnect.EventHandler do
  @moduledoc """
  Handle events for huebris
  """

  def parse(params) do
    %{
      service_id: params["service_id"],
      message: params["message"],
      type: params["Title"],
      entity: "SabNzbD Server",
      payload: params,
      source: "sabnzbd"
    }
  end

end
