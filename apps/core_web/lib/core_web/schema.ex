defmodule CoreWeb.Schema do
  @moduledoc """
    Absinthe Schema
  """
  use Absinthe.Schema

  import_types CoreWeb.Schema.Property
  import_types CoreWeb.Schema.Entity
  import_types CoreWeb.Schema.EntityType
  import_types CoreWeb.Schema.LocationType
  import_types CoreWeb.Schema.Location

  query do
    import_fields :property_queries
    import_fields :entity_queries
    import_fields :entity_type_queries
    import_fields :location_type_queries
    import_fields :location_queries
  end

  mutation do
    import_fields :entity_type_mutations
    import_fields :location_type_mutations
    import_fields :location_mutations
  end

end
