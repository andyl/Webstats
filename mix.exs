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
      aliases: aliases()
    ]
  end

  defp deps do
    [
      # ----- development and test
      {:mix_test_watch, "~> 0.8", only: :dev, runtime: false},
      # ----- utilities
      {:version_tasks, "~> 0.11.3"}
    ]
  end

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"]
    ]
  end
end
