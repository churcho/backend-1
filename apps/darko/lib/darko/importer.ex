defmodule Darko.Importer do
  @moduledoc """
  Importer Module
  """
  alias Core.{
    Places,
    Services
  }
  def update(connection) do
    locations = Places.list_locations

    for location <- locations do
      station_id = "darko-#{location.uuid}"
      target =  %{
        name: "Weather Station for #{location.name}",
        connection_uuid: connection.uuid,
        remote_id: station_id
      }

      import_entity(target)
    end
  end

  def import_entity(target) do
     Services.create_entity(target)
  end
end
