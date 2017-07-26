defmodule Reverso.Mixfile do
  use Mix.Project

  def project do
    [app: :reverso,
     version: "0.0.1",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.4",
     elixirc_paths: elixirc_paths(Mix.env),
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Reverso.Application, []},
     extra_applications: [:logger, :runtime_tools, :comeonin, :bamboo, :bamboo_smtp]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:postgrex, ">= 0.0.0"},
     {:ecto, "~> 2.1"},
     {:comeonin, "~> 3.2"},
     {:bamboo, "~> 0.8"},
     {:bamboo_smtp, "~> 1.4.0"},
     {:ex_doc, "~> 0.14.5", only: :dev},
     {:earmark,"~> 1.1.0 ", only: :dev},
     {:xml_builder, "~> 0.1.1"},
     {:mix_test_watch, "~> 0.3", only: :dev, runtime: false}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
