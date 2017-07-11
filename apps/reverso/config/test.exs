use Mix.Config

# Configure your database
config :reverso, Reverso.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "intern",
  password: "intern",
  database: "reverso_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
