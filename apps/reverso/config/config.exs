use Mix.Config

config :reverso, ecto_repos: [Reverso.Repo]

config :reverso, Reverso.Mailer,
  adapter: Swoosh.Adapters.SMTP,
  relay: "smtp.gmail.com",
  port: 587,
  username: "czupakabra96@gmail.com",
  password: "internAppunite",
  tls: :always,
  auth: :always

import_config "#{Mix.env}.exs"
