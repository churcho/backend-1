defmodule Core.Router do
  use Commanded.Commands.Router

  alias Core.People.Aggregates.{
    User,
    Role
  }

  alias Core.Places.Aggregates.{
    Location
  }
  alias Core.People.Commands.{
    RegisterUser,
    UpdateUser,
    CreateRole
  }

  alias Core.Places.Commands.{
    CreateLocation,
    DeleteLocation,
    UpdateLocation
  }

  alias Core.Support.Middleware.{Uniqueness, Validate}

  middleware Validate
  middleware Uniqueness

  identify User, by: :user_uuid, prefix: "user-"
  identify Role, by: :role_uuid, prefix: "role-"
  identify Location, by: :location_uuid, prefix: "location-"

  dispatch [
    RegisterUser,
    UpdateUser,
  ], to: User

  dispatch [
    CreateRole
  ], to: Role

  dispatch [
    CreateLocation,
    DeleteLocation,
    UpdateLocation,
  ], to: Location
end
