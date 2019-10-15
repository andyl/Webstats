import Config

# Configure your database
config :badger_data, BadgerData.Repo,
  username: "postgres",
  password: "postgres",
  database: "badger_data_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :logger, level: :error

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :badger_web, BadgerWeb.Endpoint,
  http: [port: 4002],
  server: false
