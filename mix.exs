defmodule NamedArgs.Mixfile do
  use Mix.Project

  def project do
    [app: :named_args,
     version: "0.1.0",
     elixir: "~> 1.0",
     name: "named_args",
     source_url: "git@github.com:mgwidmann/named_args.git",
     homepage_url: "https://github.com/mgwidmann/named_args",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: "Ensures default maps and keyword lists have the defaults specified.",
     docs: [
       main: NamedArgs,
       readme: "README.md"
     ],
     package: package,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
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
    [
      {:ex_doc, "~> 0.10", only: :dev},
      {:earmark, "~> 0.1", only: :dev}
    ]
  end

  defp package do
    [
      maintainers: ["Matt Widmann"],
      licenses: ["MIT"],
      links: %{github: "https://github.com/mgwidmann/named_args"}
    ]
  end
end
