defmodule Darko.Utils do
  @moduledoc """
  Util Library
  """

  def defaults, do: %{units: "us", lang: "en"}
  def user_agent, do: [{"User-agent", "Darko"}]
  def compression, do: [{"Content-Encoding", "gzip"}]
  def request_headers, do: user_agent() ++ compression()
end
