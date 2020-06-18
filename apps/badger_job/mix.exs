defmodule BadgerJob.MixProject do
  use Mix.Project

  def project do
    [
      app: :badger_job,
      version: "0.0.1",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {BadgerJob.Application, []},
      extra_applications: [:logger, :runtime_tools, :timex]
    ]
  end

  defp deps do
    [
      {:badger_data, in_umbrella: true},
      {:oban, "~> 2.0.0-rc.1"},
      {:timex, "~> 3.0"},
    ]
  end
end
