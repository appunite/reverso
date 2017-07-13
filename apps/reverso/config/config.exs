use Mix.Config

config :reverso, ecto_repos: [Reverso.Repo]

import_config "#{Mix.env}.exs"
