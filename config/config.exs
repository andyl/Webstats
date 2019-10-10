# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

# Configure Mix tasks and generators
config :logstore_data,
  ecto_repos: [LogstoreData.Repo]

config :logstore_web,
  generators: [context_app: false]

# Configures the endpoint
config :logstore_web, LogstoreWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QT4EfpUZ5vHrbWF+6GGLI37kWRWKJgGq2cuN1nmKkhBQnZgpx8MJ9QosfHGlCVGe",
  render_errors: [view: LogstoreWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LogstoreWeb.PubSub, adapter: Phoenix.PubSub.PG2]

# Sample configuration:
#
#     config :logger, :console,
#       level: :info,
#       format: "$date $time [$level] $metadata$message\n",
#       metadata: [:user_id]
#

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :logstore_web, LogstoreWeb.Endpoint, live_view: [signing_salt: "asdf"]

