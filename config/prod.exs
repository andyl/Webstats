import Config

config :logstore_web, LogstoreWeb.Endpoint,
  url: [host: "localhost", port: 5020],
  cache_static_manifest: "priv/static/cache_manifest.json"

