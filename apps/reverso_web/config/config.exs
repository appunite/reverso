# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :reverso_web,
  namespace: Reverso.Web,
  ecto_repos: [Reverso.Repo]

# Configures the endpoint
config :reverso_web, Reverso.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MGthBDEC4/JNnAD7B3g2iyaVUgUTbtK5LbvOy40H2mPzFhRUkd8R/lYq7RMNyGtI",
  render_errors: [view: Reverso.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Reverso.Web.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :reverso_web, :generators,
  context_app: :reverso

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
