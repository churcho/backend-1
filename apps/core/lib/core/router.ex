defmodule Core.Router do
  use Commanded.Commands.Router

  alias Core.Accounts.Aggregates.{
    User,
    Role
  }

  alias Core.People.Aggregates.{
    Profile
  }

  alias Core.Places.Aggregates.{
    Location,
    Zone,
    Room
  }

  alias Core.Services.Aggregates.{
    Provider,
    Connection,
    Entity
  }

  alias Core.Accounts.Commands.{
    RegisterUser,
    UpdateUser,
    CreateRole
  }

  alias Core.People.Commands.{
    CreateProfile
  }

  alias Core.Places.Commands.{
    CreateLocation,
    DeleteLocation,
    UpdateLocation,
    UpdateLocationWeather,
    CreateZone,
    DeleteZone,
    UpdateZone,
    CreateRoom,
    DeleteRoom,
    UpdateRoom
  }

  alias Core.Services.Commands.{
    RegisterProvider,
    UpdateProvider,
    CreateConnection,
    DeleteConnection,
    CreateEntity
  }

  alias Core.Support.Middleware.{Uniqueness, Validate}

  middleware Validate
  middleware Uniqueness

  identify User, by: :user_uuid, prefix: "user-"
  identify Profile, by: :profile_uuid, prefix: "profile-"
  identify Role, by: :role_uuid, prefix: "role-"
  identify Location, by: :location_uuid, prefix: "location-"
  identify Zone, by: :zone_uuid, prefix: "zone-"
  identify Room, by: :room_uuid, prefix: "room-"
  identify Provider, by: :provider_uuid, prefix: "provider-"
  identify Connection, by: :connection_uuid, prefix: "connection-"
  identify Entity, by: :entity_uuid, prefix: "entity-"

  dispatch [
    RegisterUser,
    UpdateUser,
  ], to: User

  dispatch [
    CreateProfile,
  ], to: Profile

  dispatch [
    CreateRole
  ], to: Role

  dispatch [
    CreateLocation,
    DeleteLocation,
    UpdateLocation,
    UpdateLocationWeather,
  ], to: Location

  dispatch [
    CreateZone,
    DeleteZone,
    UpdateZone,
  ], to: Zone

  dispatch [
    CreateRoom,
    DeleteRoom,
    UpdateRoom,
  ], to: Room

  dispatch [
    RegisterProvider,
    UpdateProvider,
  ], to: Provider

  dispatch [
    CreateConnection,
    DeleteConnection
  ], to: Connection

  dispatch [
    CreateEntity,
  ], to: Entity
end
