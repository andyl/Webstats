import Config

config :badger_data, BadgerData.Repo,
  username: "postgres",
  password: "postgres",
  database: "badger_data_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :badger_web, BadgerWeb.Endpoint,
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
      cd: Path.expand("../apps/badger_web/assets", __DIR__)
    ]
  ]

config :badger_web, BadgerWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/badger_web/{live,views}/.*(ex)$",
      ~r"lib/badger_web/templates/.*(eex)$"
    ]
  ]
