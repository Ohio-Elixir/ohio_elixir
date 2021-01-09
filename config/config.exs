# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ohio_elixir,
  ecto_repos: [OhioElixir.Repo]

# Configures the endpoint
config :ohio_elixir, OhioElixirWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FMJbycK0Cue3kJwPSLjg8HSVRhD+FVopcBoDhponmJvzGcn+LibtBEP0dxb8ZEls",
  render_errors: [view: OhioElixirWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: OhioElixir.PubSub,
  live_view: [signing_salt: "DzZCI9uL"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
