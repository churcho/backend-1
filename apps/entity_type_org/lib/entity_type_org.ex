defmodule EntityTypeOrg do
  @moduledoc """
  Device Org implementation.
  """
  alias EntityTypeOrg.InteriorDoor
  alias EntityTypeOrg.ExternalDoor
  alias EntityTypeOrg.DefaultType

  def register do
    InteriorDoor.register_entity_type()
    ExternalDoor.register_entity_type()
    DefaultType.register_entity_type()
  end
end
