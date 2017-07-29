defmodule SmartThingsConnect.Client do
  @moduledoc """
  SmartThings Connect Client
  """
  alias SmartThingsConnect.Client

  defstruct [
    api_token: "",
    base_url: "",
    url: "",
    format: "application/json", #Only Json for now
    headers: [] #Headers for request
  ]

  @endpoints "https://graph.api.smartthings.com/api/smartapps/endpoints"

  def new(token) do
    %Client{
      url: @endpoints,
      api_token: token,
      headers: [{"Accept", "application/json"}, {"Authorization", "Bearer "<>token}]
    }
  end

  def get_endpoints(client) do
    {:ok, resp}=HTTPoison.get(client.url, client.headers)
    Poison.decode!(resp.body)
  end


end
