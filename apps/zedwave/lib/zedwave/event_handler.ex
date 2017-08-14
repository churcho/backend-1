defmodule Zedwave.EventHandler do
  @moduledoc """
  Handle events for Zedwave
  """

  def parse(params) do
    if params["source_event"] do
        entity = Core.ServiceManager.get_entity_by_uuid(params["uuid"])
        rez =
        params
        |> Map.put("entity_id", entity.id)
        rez
    else


    if params.source_event do
      if params.source_event == "IMPORT" do
        params
      else
        entity = Core.ServiceManager.get_entity_by_uuid(params["uuid"])
        rez =
        params
        |> Map.put("entity_id", entity.id)
        rez
      end
    end
  end
end
end
