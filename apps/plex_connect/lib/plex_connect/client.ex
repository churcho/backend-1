defmodule PlexConnect.Client do
  @moduledoc """
    Client for the Plex API
  """

  alias PlexConnect.Client

  defstruct [
    token: "", #X-Plex-Token
    url: "", #Url of your local Plex Server localhost:32400
    format: "application/json", #Only Json for now
    headers: [] #Headers for request
  ]

  @doc """
  Instantiate a new client. Requiers a server IP address (String),
  port (String), and token (String).
    ##
    Client.new("127.0.0.1", "32400", "xsewewe23232")

    %Client{....}
  """
  def new(server, port, token) do
    %Client{
      url: "http://"<>server<>":"<>port,
      token: token,
      headers: [{"Accept", "application/json"}, {"X-Plex-Token", token}]
    }
  end

  def media_container(client) do
    {:ok, resp}=HTTPoison.get(client.url, client.headers)
    Poison.decode!(resp.body)
  end

  def list_sessions(client) do
    {:ok, resp}=HTTPoison.get(client.url<>"/status/sessions", client.headers)
    Poison.decode!(resp.body)
  end

  def list_servers(client) do
    {:ok, resp}=HTTPoison.get(client.url<>"/servers", client.headers)
    Poison.decode!(resp.body)
  end

  def list_sections(client) do
    {:ok, resp}=HTTPoison.get(client.url<>"/library/sections", client.headers)
    Poison.decode!(resp.body)
  end

  def show_section(client, section_id) do
    {:ok, resp}=HTTPoison.get(client.url<>"/library/sections/"<>section_id, client.headers)
    Poison.decode!(resp.body)
  end
end
