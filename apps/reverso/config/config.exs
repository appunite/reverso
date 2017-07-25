use Mix.Config

config :reverso, ecto_repos: [Reverso.Repo]

config :reverso, Reverso.Mailer,
  adapter: Bamboo.LocalAdapter

import_config "#{Mix.env}.exs"
