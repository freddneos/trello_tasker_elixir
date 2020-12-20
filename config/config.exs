# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :trello_tasker_elixir,
  ecto_repos: [TrelloTaskerElixir.Repo]

# Configures the endpoint
config :trello_tasker_elixir, TrelloTaskerElixirWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "4Zi0x+3+YFfWSGop4skYMRF9mw0Yw69o+rDJueGi5PyRUxWeTKSTkycbdojjfw+0",
  render_errors: [view: TrelloTaskerElixirWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: TrelloTaskerElixir.PubSub,
  live_view: [signing_salt: "QHgBRm++"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
