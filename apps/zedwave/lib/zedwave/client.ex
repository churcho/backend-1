defmodule Zedwave.Client do
  @moduledoc false

  @doc """
  Connect to a bridge
  """
  def connect(host) do
    IO.puts "Connected"
  end

  @url "/api"

  @doc """
  list lights
  """
  def get_entities(host) do
    {:ok, response} =
    Zedwave.get("http://" <> host <>":3000"<> @url <> "/nodes")

    if {:ok, response} do
      response.body
      |> Poison.Parser.parse!()
    end
  end

end
