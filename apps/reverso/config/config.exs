use Mix.Config

config :reverso, ecto_repos: [Reverso.Repo]

config :reverso, Reverso.Mailer,
  adapter: Bamboo.LocalAdapter

# later we will use this config probably:
#  server: "smtp.gmail.com",
#  port: 465,
#  username: "czupakabra96@gmail.com",
#  password: "internAppunite",
#  auth: :always,
#  tls: :if_avaliable,
#  allowed_tls_versions: [:"tlsv1", :"tlsv1.1", :"tlsv1.2"],
#  ssl: :always,
#  retries: 1

import_config "#{Mix.env}.exs"
