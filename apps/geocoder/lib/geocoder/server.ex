defmodule Geocoder.Server do
  @moduledoc """
  Server
  """
  require Logger
  use GenServer


  @doc """
  Starts the server
  """
  def start_link() do
  	 GenServer.start_link(__MODULE__, {})
  end


  def init(state) do
  	Geocoder.register_provider
  	{:ok, state}
  end
end
