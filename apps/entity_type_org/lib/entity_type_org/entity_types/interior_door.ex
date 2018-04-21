defmodule EntityTypeOrg.InteriorDoor do
  @moduledoc """
  Defines the schema for an Interior Door
  """
  require Logger
  alias EntityTypeOrg.InteriorDoor
  alias Core.EntityManager
  alias Core.EntityManager.EntityType

  def registration do
    %{
      name: "interior_door",
      label: "Interior Door",
      description: "An interior door"
    }
  end

  @doc """
  Register the entity_type
  """
  def register_entity_type do
    with {:ok, %EntityType{} = entity_type} <-
           EntityManager.create_or_update_entity_type(InteriorDoor.registration()) do
      Logger.info(fn ->
        "EntityType Registered as #{entity_type.name}"
      end)

      entity_type
    end
  end
end
