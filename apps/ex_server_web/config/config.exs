# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ex_server_web,
  namespace: ExServerWeb,
  ecto_repos: [ExServer.Repo]

# Configures the endpoint
config :ex_server_web, ExServerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "DZrn+mAljIPw33KFb9PjGd6JHZ0+0pxlEH+EsgfJUvJi+xjzNYHNHj7hr1KsTqTs",
  render_errors: [view: ExServerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ExServerWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ex_server_web, :generators,
  context_app: :ex_server

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
