defmodule ExVictorOps.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_victor_ops,
     source_url: "https://github.com/cagedata/ex_victor_ops",
     version: "0.1.0",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     docs: [ extras: ["README.md", "CONTRIBUTING.md"]],
     description: description,
     package: package]
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
      {:httpotion, "~> 2.2"},
      {:poison, "~> 2.1"},
      {:mock, "~> 0.1", only: :test},
      {:ex_doc, "~> 0.11", only: [:dev, :test, :docs]},
      {:earmark, only: [:dev, :test, :docs]},
      {:inch_ex, only: :docs}
    ]
  end

  defp description do
    """
    VictorOps API library for Elixir
    """
  end
end
