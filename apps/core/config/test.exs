use Mix.Config

# Print only warnings and errors during test
config :logger, level: :warn

config :ex_unit,
  capture_log: true

# Configure the event store database
config :eventstore, EventStore.Storage,
  serializer: Commanded.Serialization.JsonSerializer,
  username: "postgres",
  password: "postgres",
  database: "core_eventstore_test",
  hostname: "localhost",
  pool_size: 1

# Configure your database
config :core, Core.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "core_readstore_test",
  hostname: "localhost",
  pool: 1


config :comeonin, :bcrypt_log_rounds, 4
