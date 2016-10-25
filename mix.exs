defmodule ExVictorOps.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_victor_ops,
     source_url: "https://github.com/cagedata/ex_victor_ops",
     version: "0.3.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     docs: [ extras: ["README.md", "CONTRIBUTING.md"]],
     description: description,
     package: package,
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: ["coveralls": :test, "coveralls.detail": :test, "coveralls.post": :test],
     dialyzer: [
       # plt_file: "#{System.get_env("HOME")}/#{plt_filename}",
       flags: ["--no_native", "-Wno_match", "-Wno_return"]
     ]]
  end

  def application do
    [applications: [:logger, :httpotion, :poison]]
  end

  defp package do
    [
      maintainers: ["David Long <dlong@cagedata.com>"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/cagedata/ex_victor_ops"}
    ]
  end

  defp deps do
    [
      {:httpotion, "~> 3.0.0"},
      {:poison, "~> 3.0.0"},
      {:mock, "~> 0.1", only: :test},
      {:ex_doc, "~> 0.14", only: [:dev, :test, :docs]},
      {:earmark, ">= 0.0.0", only: [:dev, :test, :docs]},
      {:inch_ex, ">= 0.0.0", only: :docs},
      {:excoveralls, "~> 0.5", only: :test}
    ]
  end

  defp description do
    """
    VictorOps API library for Elixir
    """
  end
end
