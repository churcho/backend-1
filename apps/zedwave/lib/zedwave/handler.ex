defmodule Zedwave.Handler do
  @moduledoc """
    Handler for Zedwave
  """
  alias Zedwave.Handler.EcolinkMotion
  alias Zedwave.Handler.AeonMultiGen5

  def parse_node(node, service) do
    fingerprint = node["manufacturerid"] <> node["productid"] <> node["producttype"]

    case fingerprint do
      "0x014a0x00010x0001" ->
        EcolinkMotion.return_type(node, service)

      "0x00860x00640x0102" ->
        AeonMultiGen5.return_type(node, service)

      _ ->
        nil
    end
  end
end
