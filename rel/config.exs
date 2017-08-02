Path.join(["rel", "plugins", "*.exs"])
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Mix.Releases.Config,
    default_release: :prod,
    default_environment: Mix.env()

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"]O%?@{]*Vu=8R@eY&12wiINeS*Z^>*FSOT^s6J|9c|jN@`,ea?GRkl}tFsy.Db9e"
end

release :reverso_web do
  set version: "0.1.5"
  set applications: [
    :runtime_tools,
    reverso: :permanent,
    reverso_web: :permanent
  ]
end
