# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :core, ecto_repos: [Core.Repo]

config :commanded,
event_store_adapter: Commanded.EventStore.Adapters.EventStore

config :eventstore, column_data_type: "jsonb"
config :eventstore, EventStore.Storage,
  serializer: EventStore.JsonbSerializer,
  types: EventStore.PostgresTypes

config :commanded_ecto_projections,
repo: Core.Repo

config :vex,
  sources: [
    Core.People.Validators,
    Core.Support.Validators,
    Vex.Validators
  ]

import_config "#{Mix.env}.exs"
