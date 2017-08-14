defmodule Core.Mixfile do
  @moduledoc """
  false
  """
  use Mix.Project

  def project do
    [app: :core,
     version: "0.1.0",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.4",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     start_permanent: Mix.env == :prod,
     test_coverage: [tool: Coverex.Task],
     aliases: aliases(),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Core.Application, []},
     extra_applications: [:logger, :runtime_tools]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.3", override: true},
     {:phoenix_pubsub, "~> 1.0"},
     {:phoenix_ecto, "~> 3.2"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:phoenix_html, "~> 2.10"},
     {:timex, "~> 3.1.13"},
     {:timex_ecto, "~> 3.1.1"},
     {:guardian, "~> 0.14.2"},
     {:comeonin, "~> 3.0.2"},
     {:postgrex, "~> 0.13.2"},
     {:gettext, "~> 0.11"},
     {:cors_plug, "~> 1.2.1"},
     {:poison, "~> 3.0"},
     {:httpoison, "~> 0.11.2"},
     {:cowboy, "~> 1.1.2"},
     {:distillery, "~> 1.0"}]

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
