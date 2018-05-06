use Mix.Config

# Configure your database
config :ex_server, ExServer.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "ex_server_dev",
  hostname: "localhost",
  pool_size: 10
