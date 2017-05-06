defmodule Huebris.Client do
  @moduledoc false

  @doc """
  Connect to a bridge
  """
  def connect(host, api_key) do
    Huex.connect(host, api_key)
  end

  @doc """
  Get the lights payload
  """
  def getlights(bridge)  do
    Huex.lights(bridge)
  end
end
