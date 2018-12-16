defmodule Core.Mixfile do
  @moduledoc false
  use Mix.Project

  def project do
    [
      app: :core,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.7.2",
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
       :runtime_tools,
       :astro,
       :uuid
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
     {:event_bus, git: "https://github.com/otobus/event_bus.git"},
     {:timex, "~> 3.4"},
     {:bcrypt_elixir, "~> 1.0"},
     {:comeonin, "~> 4.0"},
     {:ecto_sql, "~> 3.0"},
     {:postgrex, ">= 0.0.0"},
     {:ecto, "~> 3.0", override: true},
     {:poison, "~> 3.0"},
     {:httpoison, "~> 1.4"},
     {:exconstructor, "~> 1.1"},
     {:uuid, "~> 1.1.8"},
     {:slugger, "~> 0.2"},
     {:ex_machina, "~> 2.2"},
     {:mix_test_watch, "~> 0.5", only: :dev, runtime: false},
     {:quantum, "~> 2.2"},
     {:crontab, "~> 1.1.3"},
     {:astro, git: "https://github.com/aussiegeek/astro.git"},
     {:vex, "~> 0.8"}
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
     test: ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
