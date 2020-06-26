import Config

# Configure Mix tasks and generators
config :badger_data,
  ecto_repos: [BadgerData.Repo]

config :badger_data, Oban,
  repo: BadgerData.Repo,
  queues: [default: 10, events: 50, media: 20]

config :badger_web,
  generators: [context_app: false]

# Configures the endpoint
config :badger_web, BadgerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QT4EfpUZ5vHrbWF+6GGLI37kWRWKJgGq2cuN1nmKkhBQnZgpx8MJ9QosfHGlCVGe",
  render_errors: [view: BadgerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: BadgerWeb.PubSub, adapter: Phoenix.PubSub.PG2]

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

config :badger_web, BadgerWeb.Endpoint, live_view: [signing_salt: "asdf"]

if Mix.env == :dev do
  config :mix_test_watch, clear: true
end
