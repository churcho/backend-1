use Mix.Config

# Configure your database
config :core, Core.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "core_dev",
  hostname: "localhost",
  pool_size: 10


# Configure the event store database
config :eventstore, EventStore.Storage,
  serializer: Commanded.Serialization.JsonSerializer,
  username: "postgres",
  password: "postgres",
  database: "core_eventstore_dev",
  hostname: "localhost",
  pool_size: 10
