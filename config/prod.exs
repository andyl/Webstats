import Config

config :badger_data, BadgerData.Repo,
  username: "postgres",
  password: "postgres",
  database: "badger_data_prod",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: false,
  pool_size: 10

key = "veryverysecretkeyeryverysecretkeyveryverysecretkeyveryverysecretkey"
config :badger_web, BadgerWeb.Endpoint,
  url: [host: "localhost", port: 5020],
  # http: [:inet6, port: 5020],
  http: [port: 5020],
  cache_static_manifest: "priv/static/cache_manifest.json",
  check_origin: false,
  server: true,
  secret_key_base: key,
  root: "."



