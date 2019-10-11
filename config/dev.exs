import Config

config :logstore_data, LogstoreData.Repo,
  username: "postgres",
  password: "postgres",
  database: "logstore_data_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :logstore_web, LogstoreWeb.Endpoint,
  http: [port: 4020],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    node: [
      "node_modules/webpack/bin/webpack.js",
      "--mode",
      "development",
      "--watch-stdin",
      cd: Path.expand("../apps/logstore_web/assets", __DIR__)
    ]
  ]

config :logstore_web, LogstoreWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/logstore_web/{live,views}/.*(ex)$",
      ~r"lib/logstore_web/templates/.*(eex)$"
    ]
  ]
