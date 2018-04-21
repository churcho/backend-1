defmodule EntityTypeOrg.DefaultType do
  @moduledoc """
  Defines the schema for an External Door
  """
  require Logger
  alias EntityTypeOrg.DefaultType
  alias Core.EntityManager
  alias Core.EntityManager.EntityType

  def registration do
    %{
      name: "default_type",
      label: "Default Type",
      description: "Default Entity Type"
    }
  end

  @doc """
  Register the entity_type
  """
  def register_entity_type do
    with {:ok, %EntityType{} = entity_type} <-
           EntityManager.create_or_update_entity_type(DefaultType.registration()) do
      Logger.info(fn ->
        "EntityType Registered as #{entity_type.name}"
      end)

      entity_type
    end
  end
end
