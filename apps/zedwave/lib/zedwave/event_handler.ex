defmodule Zedwave.EventHandler do
  @moduledoc """
  Handle events for Zedwave
  """

  def parse(params) do
    entity = Core.ServiceManager.get_entity_by_uuid(params["uuid"])
    rez =
    params
    |> Map.put("entity_id", entity.id)
    rez
  end

end
