use Mix.Config

# Configure your database
config :reverso, Reverso.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "reverso_dev",
  hostname: "localhost",
  pool_size: 10
