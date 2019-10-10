import Config

# Configure your database
config :logstore_data, LogstoreData.Repo,
  username: "postgres",
  password: "postgres",
  database: "logstore_data_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :logstore_web, LogstoreWeb.Endpoint,
  http: [port: 4002],
  server: false
