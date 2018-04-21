defmodule Zedwave.Client do
  @moduledoc false

  alias Poison.Parser

  @doc """
  Connect to a bri
  """
  def connect(_host) do
    IO.puts("Connected")
  end

  @url "/api"

  @doc """
  list entities
  """
  def get_entities(service) do
    {:ok, response} = Zedwave.get("http://#{service.host}:#{service.port}/api/nodes")

    if response != nil do
      response.body
      |> Parser.parse!()
    end
  end

  def update_imported_entity(host, entity) do
    headers = [{"Content-type", "application/json"}]

    body = '{"lorpEntityId":#{entity.id}, "lorpServiceId":#{entity.service.id}}'

    {:ok, _response} =
      Zedwave.put("http://#{host}:3000#{@url}/nodes/#{entity.uuid}", body, headers, [])
  end

  def send_controller_command(host, command) do
    {:ok, _response} =
      Zedwave.post("http://" <> host <> ":3000" <> @url <> "/commands/" <> command, [])
  end

  def send_node_command(host, entity, command) do
    {:ok, _response} =
      Zedwave.post("http://#{host}:3000#{@url}/nodes/#{entity}/send-command/#{command}", [])
  end
end
