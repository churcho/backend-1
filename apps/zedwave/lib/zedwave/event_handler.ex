defmodule Zedwave.EventHandler do
  @moduledoc """
  Handle events for Zedwave
  """

  def parse(params) do
    IO.inspect params
    IO.puts "GETTING ENTITY BY UUID"
    entity = Core.ServiceManager.get_entity_by_uuid(params["uuid"])

    IO.puts "updating params with entity id.......#{entity.id}"

    rez =
    params
    |> Map.put("entity_id", entity.id)

    IO.inspect rez
    rez


  end

end
