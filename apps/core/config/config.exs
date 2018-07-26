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
    :place_location,
    :place_zone,
    :place_room
  ], # list of atoms
  ttl: 30_000_000, # integer
  time_unit: :micro_seconds# atom

import_config "#{Mix.env}.exs"
import_config "dev.secret.exs"
