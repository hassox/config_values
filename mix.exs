defmodule ConfigValues.Mixfile do
  use Mix.Project

  @version "1.0.0"
  @maintainers [
    "Daniel Neighman",
  ]
  @url "https://github.com/hassox/config_values"

  def project do
    [app: :config_values,
     version: @version,
     elixir: "~> 1.2",
     description: "Interpolated configuration values",
     source_url: @url,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     maintainers: @maintainers,
     homepage_url: @url,
     docs: docs,
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  def docs do
    [
      extras: ["README.md", "CHANGELOG.md"],
      source_ref: "v#{@version}",
      main: "extra-readme"
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    []
  end

  defp package do
    [
      maintainers: @maintainers,
      licenses: ["MIT"],
      links: %{github: @url},
      files: ~w(lib) ++ ~w(CHANGELOG.md LICENSE mix.exs README.md)
    ]
  end
end
