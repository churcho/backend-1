defmodule EntityTypeOrg.ExternalDoor do
  @moduledoc """
  Defines the schema for an External Door
  """
  require Logger
  alias EntityTypeOrg.ExternalDoor
  alias Core.EntityManager
  alias Core.EntityManager.EntityType

  def registration do
    %{
      name: "external_door",
      label: "External Door",
      description: "An external door"
    }
  end

  @doc """
  Register the entity_type
  """
  def register_entity_type do
    with {:ok, %EntityType{} = entity_type} <-
           EntityManager.create_or_update_entity_type(ExternalDoor.registration()) do
      Logger.info(fn ->
        "EntityType Registered as #{entity_type.name}"
      end)

      entity_type
    end
  end
end
