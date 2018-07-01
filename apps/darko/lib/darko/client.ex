defmodule Darko.Client do
  @moduledoc false
  import Darko.Utils
  use HTTPoison.Base
  alias Darko.Parser


  @base_url "https://api.darksky.net/forecast"


  def forecast(lat, lng, token, params \\ defaults()) do
    read("#{token}/#{lat},#{lng}", params)
  end

  def time_machine(lat, lng, time, token, params \\ defaults()) do
   read("#{token}/#{lat},#{lng},#{time}", params)
  end

  def build_url(path_arg, query_params) do
  query_params = query_params
    |> process_params
  "#{@base_url}/#{path_arg}?#{URI.encode_query(query_params)}"
  end

  def read(path_arg, query_params \\ %{}) do
    path_arg
    |> build_url(query_params)
    |> get(request_headers())
    |> Parser.parse
  end

  def process_params(nil) do
    defaults()
  end

  def process_params(params) do
    defaults()
    |> Map.merge(params)
    |> Map.delete(:__struct__)
  end

end
