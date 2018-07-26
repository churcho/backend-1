defmodule Darko.Importer do
  @moduledoc """
  Importer Module
  """
  alias Core.{
    Places
  }
  def update(connection) do
    locations = Places.list_locations

    for location <- locations do
      station_id = "darko-#{location.id}"
      target =  %{
        name: "Weather Station for #{location.name}",
        connection_id: connection.id,
        remote_id: station_id
      }

      import_entity(target)
    end
  end

  def import_entity(target) do
    IO.inspect target
  end
end
