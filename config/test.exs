import Config

# Configure your database
config :badger_data, BadgerData.Repo,
  username: "postgres",
  password: "postgres",
  database: "badger_data_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :badger_data, Oban, crontab: false, queues: false, plugins: false

config :logger, level: :error

config :badger_web, BadgerWeb.Endpoint,
  http: [port: 4002],
  server: false
