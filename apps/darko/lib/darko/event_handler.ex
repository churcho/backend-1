defmodule Darko.EventHandler do
  @moduledoc """
  Handle events for huebris
  """
  require Logger


  def parse(params) do
    Logger.info fn ->
      "Darko parsing event"
    end
    
    params
  end

end
