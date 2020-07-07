defmodule Badger.MixProject do
  use Mix.Project

  @version "0.0.1"

  def project do
    [
      apps_path: "apps",
      version: @version,
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      releases: [
        badger: [
          applications: [
            badger_data: :permanent,
            badger_web: :permanent
          ]
        ]
      ]
    ]
  end

  defp deps do
    [
      {:mix_test_watch, "~> 1.0", only: :dev, runtime: false},
      {:version_tasks, "~> 0.11.3"},
      {:app_util, path: "~/src/app_util"}
    ]
  end

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seed_#{Mix.env()}.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"]
    ]
  end
end
