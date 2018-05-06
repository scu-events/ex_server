use Mix.Config

config :ex_server, ecto_repos: [ExServer.Repo]

import_config "#{Mix.env}.exs"
