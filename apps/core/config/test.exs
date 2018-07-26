use Mix.Config

# Print only warnings and errors during test
config :logger, level: :warn

config :ex_unit,
  capture_log: true


# Configure your database
config :core, Core.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "core_test",
  hostname: "localhost",
  pool_size: 10

