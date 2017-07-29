# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :core,
  ecto_repos: [Core.Repo]

# Configures the endpoint
config :core, CoreWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "97FeC+AEph9EkkLxeuex6DnWzpU/mf9PuATczk7r/J15tz9xEy14MQR4o+Swm9Sv",
  render_errors: [view: CoreWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Core.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]


# Configures guardian
config :guardian, Guardian,
  issuer: "Lorp",
  ttl: {3, :days},
  verify_issuer: true,
  secret_key: "K5U15rCwqam0hz3EYovOp133hij04IVoFtsbKTgfxwdfBL91zBb8mH2WqzgMtpXC",
  serializer: Core.GuardianSerializer
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
