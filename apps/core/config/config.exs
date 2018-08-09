# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :core, ecto_repos: [Core.Repo]


config :vex,
  sources: [
    Vex.Validators
  ]
config :event_bus,
  topics: [
    :places_location_created,
    :places_location_updated,
    :places_location_deleted,
    :places_location_event,
    :places_zone_created,
    :places_zone_updated,
    :places_zone_deleted,
    :places_zone_event,
    :places_room_created,
    :places_room_updated,
    :places_room_deleted,
    :places_room_event
  ], # list of atoms
  ttl: 30_000_000, # integer
  time_unit: :micro_seconds# atom

import_config "#{Mix.env}.exs"
import_config "dev.secret.exs"
