defmodule Collidex.Mixfile do
  use Mix.Project

  def project do
    [app: :collidex,
     version: "0.1.0",
     elixir: "~> 1.3",
     description: "A 2D shape collision detection library",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
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
      { :graphmath, "~> 1.0.2" },
      { :excheck, "~> 0.5.0", only: :test},
      { :triq, github: "triqng/triq", only: :test},
      { :ex_spec, only: :test },
      { :mix_test_watch, "~> 0.2", only: :dev}
    ]
  end
end
