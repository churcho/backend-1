defmodule Core.Mixfile do
  @moduledoc """
  false
  """
  use Mix.Project

  def project do
    [
      app: :core,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.6.5",
      elixirc_paths: elixirc_paths(Mix.env),
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Core.Application, []},
     extra_applications: [
       :logger,
       :ex_machina,
       :eventstore,
       :runtime_tools
      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
     {:timex, "~> 3.2.1"},
     {:timex_ecto, "~> 3.2.1"},
     {:bcrypt_elixir, "~> 1.0"},
     {:comeonin, "~> 4.0"},
     {:commanded, "~> 0.16"},
     {:commanded_ecto_projections, "~> 0.6"},
     {:commanded_eventstore_adapter, "0.4.0"},
     {:postgrex, "~> 0.13.0"},
     {:ecto, "~> 2.2.8"},
     {:poison, "~> 3.1"},
     {:httpoison, "~> 1.1.0"},
     {:exconstructor, "~> 1.1"},
     {:uuid, "~> 1.1.8"},
     {:slugger, "~> 0.2"},
     {:ex_machina, "~> 2.2"},
     {:mix_test_watch, "~> 0.5", only: :dev, runtime: false},
     {:vex, "~> 0.6"}
    ]

  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
     "event_store.reset": ["event_store.drop", "event_store.create", "event_store.init"],
     "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
