defmodule PhoenixTrello.Mixfile do
  use Mix.Project

  def project do
    [
      app: :phoenix_trello,
      version: "0.0.1",
      elixir: "~> 1.0",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix] ++ Mix.compilers(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {PhoenixTrello, []},
      applications: [
        :comeonin,
        :cowboy,
        :ecto_sql,
        :logger,
        :phoenix_ecto,
        :phoenix_html,
        :phoenix_pubsub,
        :phoenix,
        :postgrex
      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_), do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:comeonin, "~> 2.5.3"},
      {:cowboy, "~> 1.0"},
      {:credo, "~> 0.4.11", only: [:dev, :test]},
      {:ecto_sql, "~> 3.0"},
      {:ex_machina, "~> 2.2", only: :test},
      {:exactor, "~> 2.2.0"},
      {:gettext, "~> 0.16.0"},
      {:guardian, "0.14.5"},
      {:hound, "~> 1.0.2"},
      {:mix_test_watch, "~> 0.2", only: :dev},
      {:phoenix_ecto, "~> 4.0"},
      {:phoenix_html, "~> 2.3"},
      {:phoenix_live_reload, "~> 1.0.5", only: :dev},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix, "~> 1.3.0"},
      {:plug_cowboy, "~> 1.0"},
      {:postgrex, "~> 0.14.1"}
    ]
  end

  # Aliases are shortcut or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
