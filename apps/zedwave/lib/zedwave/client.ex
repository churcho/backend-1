defmodule Zedwave.Client do
  @moduledoc false

  @doc """
  Connect to a bri
  """
  def connect(host) do
    IO.puts "Connected"
  end

  @url "/api"

  @doc """
  list entities
  """
  def get_entities(host) do
    {:ok, response} =
    Zedwave.get("http://" <> host <>":3000"<> @url <> "/nodes")

    if {:ok, response} do
      response.body
      |> Poison.Parser.parse!()
    end
  end

  def send_controller_command(host, command) do
    {:ok, response} =
    Zedwave.post("http://" <> host <>":3000"<> @url <> "/commands/"<> command, [])

    if {:ok, response} do
      IO.inspect response.body
    end
  end

  def send_node_command(host, entity, command) do
    {:ok, response} =
    Zedwave.post("http://#{host}:3000#{@url}/nodes/#{entity}/send-command/#{command}", [])

    if {:ok, response} do
      IO.inspect response.body
    end
  end


end
